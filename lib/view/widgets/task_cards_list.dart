import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/utils/constants/colors.dart';
import 'package:task_manager/view/widgets/task_card.dart';
import '../../bloc/task_management/task_cubit.dart';
import '../../bloc/task_management/task_state.dart';
import '../../data/models/task.dart';
import '../screens/details_screen.dart';

class TaskCardsList extends StatefulWidget {
  final int? userId;
  final void Function() refreshTasks;

  const TaskCardsList({Key? key, this.userId, required this.refreshTasks})
      : super(key: key);

  @override
  _TaskCardsListState createState() => _TaskCardsListState();
}

class _TaskCardsListState extends State<TaskCardsList> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    if (widget.userId != null) {
      context.read<TaskCubit>().getTasksByUserId(widget.userId!);
    } else {
      context.read<TaskCubit>().getAllTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TaskLoaded) {
          setState(() {
            _tasks = state.tasks;
          });
        }
      },
      builder: (context, state) {
        if (state is TaskLoading) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              CircularProgressIndicator(
                color: kSecondary,
              ),
            ],
          );
        } else if (state is TaskError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Column(
            children: _tasks.map((task) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(taskId: task.id),
                      ),
                    );
                  },
                  child: TaskCard(
                    title: task.todo,
                    isCompleted: task.completed,
                    taskId: task.id,
                  ),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
