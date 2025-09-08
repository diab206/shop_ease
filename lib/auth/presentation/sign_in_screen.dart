import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_ease/core/theme/app_colors.dart';
import 'package:shop_ease/core/widgets/custom_auth_button.dart';
import 'package:shop_ease/core/widgets/custom_auth_text_field.dart';
import 'package:shop_ease/core/widgets/custom_dialog_helper.dart';
import 'package:shop_ease/core/widgets/custom_error_dialog.dart';
import 'package:shop_ease/home/presentation/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // CORRECT: Use signInWithEmailAndPassword for signing in existing users
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        
        // Log successful sign in
        if (kDebugMode) {
          print('User signed in successfully: ${userCredential.user?.email}');
        }
        if (kDebugMode) {
          print('User UID: ${userCredential.user?.uid}');
        }
        
        // Success dialog
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => CustomSuccessDialog(
            title: "Welcome!",
            message: "Signed in successfully",
            onClose: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) =>  HomeScreen()),
              );
            },
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (kDebugMode) {
          print('Firebase Auth Error: ${e.code} - ${e.message}');
        }
        String message = "Login failed";
        if (e.code == 'user-not-found') {
          message = "No user found with this email";
        } else if (e.code == 'wrong-password') {
          message = "Wrong password";
        } else if (e.code == 'invalid-email') {
          message = "Invalid email format";
        } else if (e.code == 'user-disabled') {
          message = "This account has been disabled";
        } else if (e.code == 'too-many-requests') {
          message = "Too many failed attempts. Try again later";
        }

        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => CustomErrorDialog(message: message),
        );
      } catch (e) {
        if (kDebugMode) {
          print('Unexpected error: $e');
        }
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => CustomErrorDialog(message: "Unexpected error occurred"),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, Colors.deepPurpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Welcome Back",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Sign in to ShopEase",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Email
                    CustomAuthTextField(
                      controller: _emailController,
                      label: "Email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        if (!value.contains("@")) {
                          return "Email must contain @";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password
                    CustomAuthTextField(
                      controller: _passwordController,
                      label: "Password",
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Sign In Button
                    CustomAuthButton(
                      text: "Sign In",
                      onPressed: _submitForm,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}