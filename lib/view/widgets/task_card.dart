import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/utils/constants/colors.dart';
import '../../bloc/task_management/task_cubit.dart';
import '../../utils/constants/font_styles.dart';
import 'complete_check_box.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final int taskId;

  const TaskCard({
    Key? key,
    required this.title,
    required this.isCompleted,
    required this.taskId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGrey,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24,18,0,18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                style: Styles.textStyle18,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 25),
            Row(
              children: [
                CompleteCheckBox(
                  isSelected: isCompleted,
                  taskId: taskId,
                ),
                SizedBox(height: 10),
                IconButton(
                  onPressed: () {
                    context.read<TaskCubit>().deleteTask(taskId);
                  },
                  icon: Icon(Icons.remove_circle_outline,color: Colors.red,),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
