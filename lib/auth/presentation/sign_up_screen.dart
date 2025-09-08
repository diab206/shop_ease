import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_ease/core/theme/app_colors.dart';
import 'package:shop_ease/core/widgets/custom_auth_button.dart';
import 'package:shop_ease/core/widgets/custom_auth_text_field.dart';
import 'package:shop_ease/core/widgets/custom_dialog_helper.dart';
import 'package:shop_ease/core/widgets/custom_error_dialog.dart';
import 'package:shop_ease/home/presentation/home_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

final FirebaseAuth _auth = FirebaseAuth.instance;

void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    try {
      // Add loading state here if needed
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      
      // Log successful creation
      if (kDebugMode) {
        print('User created successfully: ${userCredential.user?.email}');
      }
      if (kDebugMode) {
        print('User UID: ${userCredential.user?.uid}');
      }
      
      // Success dialog
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => CustomSuccessDialog(
          title: "Success!",
          message: "Account created successfully",
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
      String message = "Something went wrong";
      if (e.code == 'email-already-in-use') {
        message = "Email already in use";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email format";
      } else if (e.code == 'weak-password') {
        message = "Password is too weak";
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
                    // Title
                    const Text(
                      "Create Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Join ShopEase today",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Fields
                    CustomAuthTextField(
                      controller: _nameController,
                      label: "Full Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your full name";
                        }
                        if (value[0] != value[0].toUpperCase()) {
                          return "First letter must be uppercase";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    CustomAuthTextField(
                      controller: _confirmPasswordController,
                      label: "Confirm Password",
                      obscureText: true,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Button
                    CustomAuthButton(
                      text: "Create Account",
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
