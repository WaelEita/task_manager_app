import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/view/widgets/task_card.dart';
import '../../bloc/task_management/task_cubit.dart';
import '../../bloc/task_management/task_state.dart';

class TaskCardsList extends StatefulWidget {
  final int userId;

  const TaskCardsList({Key? key, required this.userId}) : super(key: key);

  @override
  _TaskCardsListState createState() => _TaskCardsListState();
}

class _TaskCardsListState extends State<TaskCardsList> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().getTasksByUserId(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoaded) {
          return Column(
            children: state.tasks.map((task) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TaskCard(
                  title: task.todo,
                  isCompleted: task.completed,
                ),
              );
            }).toList(),
          );
        } else if (state is TaskLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TaskError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
