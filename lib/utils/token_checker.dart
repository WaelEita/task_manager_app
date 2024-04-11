import 'package:flutter/material.dart';
import 'package:task_manager/utils/token_manager.dart';
import 'package:task_manager/view/screens/home_screen.dart';
import 'package:task_manager/view/screens/login_screen.dart';

class TokenChecker extends StatelessWidget {
  const TokenChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: TokenManager.getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data != null) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
