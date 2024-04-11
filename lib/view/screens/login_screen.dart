import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/utils/constants/font_styles.dart';
import '../../bloc/authentication/authentication_cubit.dart';
import '../../bloc/authentication/authentication_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
              prefixIcon: Icons.person,
              controller: _nameController,
              keyboardType: TextInputType.name,
              hintText: 'User name',
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
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CustomButton(
                    text: 'Logging In...',
                    onPressed: null,
                    isLoading: true,
                  );
                } else if (state is Authenticated) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  });
                  return const SizedBox();
                } else {
                  return CustomButton(
                    text: 'Log In',
                    onPressed: () {
                      final String name = _nameController.text.trim();
                      final String password = _passwordController.text.trim();

                      if (name.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Username and password cannot be empty',
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }

                      context.read<AuthCubit>().login(context, name, password);
                    },
                    isLoading: false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
