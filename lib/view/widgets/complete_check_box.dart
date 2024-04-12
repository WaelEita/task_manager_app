import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
import '../../bloc/task_management/task_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteCheckBox extends StatelessWidget {
  final bool isSelected;
  final int taskId;

  const CompleteCheckBox({
    Key? key,
    required this.isSelected,
    required this.taskId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<TaskCubit>().updateTask(taskId, !isSelected);
      },
      child: Container(
        color: kSecondary,
        height: 60,
        width: 40,
        child: Center(
          child: isSelected
              ? SvgPicture.asset(
            AssetsData.checkCircle,
          )
              : const Icon(Icons.circle_outlined, color: black),
        ),
      ),
    );
  }
}
