import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_manager.dart';
import '../../data/models/task.dart';
import '../../data/repositories/task_repository.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository _taskRepository = TaskRepository();

  TaskCubit() : super(TaskInitial());

  void _emitLoading() {
    emit(TaskLoading());
  }

  void _emitError(String errorMessage) {
    emit(TaskError(errorMessage));
  }

  void _emitTasksLoaded(List<Task> tasks) {
    emit(TaskLoaded(tasks));
  }

  void getAllTasks() async {
    _emitLoading();
    try {
      final tasks = await DataManager.getTasks();
      _emitTasksLoaded(tasks);
      final updatedTasks = await _taskRepository.getAllTasks();
      _emitTasksLoaded(updatedTasks);
      await DataManager.saveTasks(updatedTasks);
    } catch (error) {
      _emitError('Failed to load tasks');
    }
  }

  void getTaskById(int id) async {
    _emitLoading();
    try {
      final task = await _taskRepository.getTaskById(id);
      if (task != null) {
        _emitTasksLoaded([task]);
      } else {
        _emitError('Failed to load task');
      }
    } catch (error) {
      _emitError('Failed to load task');
    }
  }

  void getTasksByUserId(int userId) async {
    _emitLoading();
    try {
      final tasks = await DataManager.getTasks();
      if (tasks.isNotEmpty) {
        final userTasks = tasks.where((task) => task.userId == userId).toList();
        if (userTasks.isNotEmpty) {
          _emitTasksLoaded(userTasks);
        } else {
          final tasksByUserId = await _taskRepository.getTasksByUserId(userId);
          if (tasksByUserId != null) {
            _emitTasksLoaded(tasksByUserId);
            await DataManager.saveTasks(tasksByUserId);
          } else {
            _emitError('Failed to load tasks for user');
          }
        }
      } else {
        final tasksByUserId = await _taskRepository.getTasksByUserId(userId);
        if (tasksByUserId != null) {
          _emitTasksLoaded(tasksByUserId);
          await DataManager.saveTasks(tasksByUserId);
        } else {
          _emitError('Failed to load tasks for user');
        }
      }
    } catch (error) {
      _emitError('Failed to load tasks for user');
    }
  }

  void addTask(String todo, bool completed, int userId) async {
    _emitLoading();
    try {
      final task = await _taskRepository.addTask(todo, completed, userId);
      if (task != null) {
        emit(TaskAdded(task));
        final updatedTasks = await _taskRepository.getAllTasks();
        await DataManager.saveTasks(updatedTasks);
      } else {
        _emitError('Failed to add task');
      }
    } catch (error) {
      _emitError('Failed to add task');
    }
  }

  void updateTask(int id, bool completed) async {
    _emitLoading();
    try {
      final task = await _taskRepository.updateTask(id, completed);
      if (task != null) {
        emit(TaskUpdated(task));
        final updatedTasks = await _taskRepository.getAllTasks();
        await DataManager.saveTasks(updatedTasks);
      } else {
        _emitError('Failed to update task status');
      }
    } catch (error) {
      _emitError('Failed to update task status');
    }
  }

  void deleteTask(int id) async {
    _emitLoading();
    try {
      final task = await _taskRepository.deleteTask(id);
      if (task != null) {
        emit(TaskDeleted(task));
        final updatedTasks = await _taskRepository.getAllTasks();
        await DataManager.saveTasks(updatedTasks);
      } else {
        _emitError('Failed to delete task');
      }
    } catch (error) {
      _emitError('Failed to delete task');
    }
  }
}
