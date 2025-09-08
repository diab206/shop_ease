import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart'; 
import 'package:shop_ease/auth/presentation/welcome_screen.dart';
import 'package:shop_ease/core/theme/app_colors.dart';
import 'package:shop_ease/firebase_options.dart';
import 'package:shop_ease/home/presentation/home_screen.dart';
import 'package:shop_ease/core/providers/localization_provider.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => LocalizationProvider(),
      child: DevicePreview(
        enabled: true,
        builder: (context) => const ShopEaseApp(),
      ),
    ),
  );
}

class ShopEaseApp extends StatelessWidget {
  const ShopEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocalizationProvider>(context);

    return MaterialApp(
      title: 'ShopEase',
      debugShowCheckedModeBanner: false,
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,

      // ✅ Localization
      locale: Locale(localeProvider.languageCode),

      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          elevation: 0,
        ),
      ),

      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return const HomeScreen(); // ✅ Logged in
          }
          return const WelcomeScreen(); // ❌ Not logged in
        },
      ),
    );
  }
}
