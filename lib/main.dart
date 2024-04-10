import 'package:flutter/material.dart';
import 'package:task_manager/utils/colors.dart';
import 'package:task_manager/view/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(primaryColor: kPrimaryColor),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
