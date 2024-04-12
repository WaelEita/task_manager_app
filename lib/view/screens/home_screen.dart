import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/utils/constants/colors.dart';
import 'package:task_manager/utils/constants/font_styles.dart';
import '../../bloc/task_management/task_cubit.dart';
import '../widgets/button_choice_row.dart';
import '../widgets/task_cards_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                TaskCardsList(
                  userId: _selectedIndex == 0 ? 5 : null,
                  refreshTasks: _loadTasks,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
