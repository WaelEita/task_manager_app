import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/task_management/task_cubit.dart';
import '../../bloc/task_management/task_state.dart';
import '../widgets/details_app_bar.dart';
import '../widgets/details_description.dart';

class DetailsScreen extends StatefulWidget {
  final int taskId;

  const DetailsScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late TaskCubit _taskCubit;

  @override
  void initState() {
    super.initState();
    _taskCubit = context.read<TaskCubit>();
    _taskCubit.getTaskById(widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TaskLoaded) {
                final task = state.tasks.first;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DetailsAppBar(),
                    const SizedBox(height: 30),
                    DetailsDescription(
                      description: task.todo,
                      isCompleted: task.completed,
                    ),
                  ],
                );
              } else if (state is TaskError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: Text('Something went wrong!'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
