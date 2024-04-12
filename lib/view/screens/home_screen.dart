import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/utils/constants/colors.dart';
import 'package:task_manager/utils/constants/font_styles.dart';
import '../../bloc/task_management/task_cubit.dart';
import '../../bloc/task_management/task_state.dart';
import '../widgets/button_choice_row.dart';
import '../widgets/task_cards_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent({Key? key}) : super(key: key);

  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    if (_selectedIndex == 0) {
      context.read<TaskCubit>().getTasksByUserId(5);
    } else {
      context.read<TaskCubit>().getAllTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondary,
        onPressed: () {
          context.read<TaskCubit>().addTask('New Task', false, 5);
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const Text(
                  'Task Manager',
                  style: Styles.textStyle18,
                ),
                const SizedBox(height: 30),
                ButtonChoiceRow(
                  onIndexChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                    _loadTasks();
                  },
                ),
                const SizedBox(height: 30),
                BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, state) {
                    if (state is TaskLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TaskLoaded) {
                      return TaskCardsList(
                        userId: _selectedIndex == 0 ? 5 : null,
                        refreshTasks: _loadTasks,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
