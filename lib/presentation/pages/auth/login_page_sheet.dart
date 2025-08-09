import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hr/presentation/pages/auth/widgets/login_contact.dart';
import 'package:hr/presentation/pages/landing/widgets/logo_text.dart';
import 'widgets/login_input_field.dart';
import 'widgets/login_checkbox_forgot.dart';
import 'widgets/login_button.dart';

class LoginPageSheet extends StatelessWidget {
  const LoginPageSheet({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(9, 0, 0, 0),
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 92),
              LogoText(topMargin: screenHeight * 0.1),
              const SizedBox(height: 150),
              LoginInputField(
                label: 'Email',
                hintText: 'Enter your email',
                isPassword: false,
                controller: emailController,
              ),
              const SizedBox(height: 12),
              LoginInputField(
                label: 'Password',
                hintText: 'Enter your password',
                isPassword: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),
              const LoginCheckboxAndForgot(),
              const SizedBox(height: 22),
              LoginButton(
                emailController: emailController,
                passwordController: passwordController,
              ),
              const Spacer(),
              const LoginContact(),
            ],
          ),
        ],
      ),
    );
  }
}

