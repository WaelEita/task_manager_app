import 'package:flutter/material.dart';
import 'package:task_manager/utils/constants/colors.dart';
import '../../utils/constants/font_styles.dart';
import 'complete_check_box.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final bool isCompleted;

  const TaskCard({
    Key? key,
    required this.title,
    required this.isCompleted,
  }) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGrey,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.title,
                style: Styles.textStyle18,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 25),
            CompleteCheckBox(
              isSelected: isSelected,
              onChanged: (bool newValue) {
                setState(() {
                  isSelected = newValue;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
