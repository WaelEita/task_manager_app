import 'package:flutter/material.dart';
import 'package:task_manager/utils/constants/font_styles.dart';
import '../widgets/button_choice_row.dart';
import '../widgets/task_cards_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text(
                'Task Manager',
                style: Styles.boldTextStyle26,
              ),
              SizedBox(height: 30),
              ButtonChoiceRow(),
              SizedBox(height: 30),
              TaskCardsList(userId: 5,),
            ],
          ),
        ),
      ),
    );
  }
}

