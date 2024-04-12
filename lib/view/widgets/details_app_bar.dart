import 'package:flutter/material.dart';
import '../../utils/constants/font_styles.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_backspace,
            size: 30,
          ),
        ),
        Text(
          'Task Details',
          style: Styles.textStyle20,
        ),
        Container()
      ],
    );
  }
}