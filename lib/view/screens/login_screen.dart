import 'package:flutter/material.dart';
import 'package:task_manager/utils/colors.dart';
import 'package:task_manager/utils/font_styles.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome Back!',
              style: Styles.boldTextStyle26,
            ),
            const SizedBox(height: 23),
            CustomTextField(
              title: 'Email Address',
              prefixIcon: Icons.email_outlined,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Email',
            ),
            const SizedBox(height: 27),
            CustomTextField(
              title: 'Password',
              prefixIcon: Icons.lock_outline,
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 55),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: kSecondary),
                child: Center(
                    child: Text(
                  'Log In',
                  style: Styles.boldTextStyle26.copyWith(color: black),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
