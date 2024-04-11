import 'package:flutter/material.dart';
import 'package:task_manager/utils/bloc_providers.dart';
import 'package:task_manager/utils/constants/colors.dart';
import 'package:task_manager/utils/token_checker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBlocProviders(
      MaterialApp(
        theme: ThemeData.dark().copyWith(primaryColor: kPrimaryColor),
        debugShowCheckedModeBanner: false,
        home: TokenChecker(),
      ),
    );
  }
}
