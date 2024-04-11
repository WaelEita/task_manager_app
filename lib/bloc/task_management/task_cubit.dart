import 'package:flutter_bloc/flutter_bloc.dart';
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
      final tasks = await _taskRepository.getAllTasks();
      if (tasks != null) {
        _emitTasksLoaded(tasks);
      } else {
        _emitError('Failed to load tasks');
      }
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
      final tasks = await _taskRepository.getTasksByUserId(userId);
      if (tasks != null) {
        _emitTasksLoaded(tasks);
      } else {
        _emitError('Failed to load tasks');
      }
    } catch (error) {
      _emitError('Failed to load tasks');
    }
  }

  void addTask(String todo, bool completed, int userId) async {
    _emitLoading();
    try {
      final task = await _taskRepository.addTask(todo, completed, userId);
      if (task != null) {
        emit(TaskAdded(task));
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
      } else {
        _emitError('Failed to delete task');
      }
    } catch (error) {
      _emitError('Failed to delete task');
    }
  }
}
