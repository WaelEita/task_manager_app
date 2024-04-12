import 'package:flutter/material.dart';
import 'package:task_manager/utils/constants/colors.dart';
import '../../utils/constants/font_styles.dart';

class DetailsDescription extends StatelessWidget {
  final bool isCompleted;
  final String description;

  const DetailsDescription({
    Key? key,
    required this.isCompleted,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Task Details',
              style: Styles.boldTextStyle18,
            ),
            Text(
              isCompleted ? 'Completed' : 'Uncompleted',
              style: Styles.boldTextStyle18.copyWith(
                color: isCompleted ? kSecondary : Colors.red,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Text(
          description,
          style: Styles.textStyle14,
        )
      ],
    );
  }
}
