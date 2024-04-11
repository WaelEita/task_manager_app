import '../../utils/api_error_handler.dart';
import '../../utils/api_helper.dart';
import '../models/task.dart';

class TaskRepository {
  static const String baseUrl = 'https://dummyjson.com/todos';

  Future<List<Task>> getAllTasks({int limit = 0, int skip = 0}) async {
    try {
      final response =
      await ApiHelper.getRequest('$baseUrl?limit=$limit&skip=$skip');
      final responseData = ApiHelper.handleResponse(response);
      if (responseData != null) {
        final todos = responseData['todos'] as List<dynamic>;
        return todos.map((todo) => Task.fromJson(todo)).toList();
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (error) {
      _handleError('Get all tasks', error);
      return [];
    }
  }

  Future<Task?> getTaskById(int id) async {
    try {
      final response = await ApiHelper.getRequest('$baseUrl/$id');
      final responseData = ApiHelper.handleResponse(response);
      if (responseData != null) {
        return Task.fromJson(responseData);
      } else {
        throw Exception('Failed to load task');
      }
    } catch (error) {
      _handleError('Get task by ID', error);
      return null;
    }
  }

  Future<List<Task>> getTasksByUserId(int userId) async {
    try {
      final response = await ApiHelper.getRequest('$baseUrl/user/$userId');
      final responseData = ApiHelper.handleResponse(response);
      if (responseData != null) {
        final todos = responseData['todos'] as List<dynamic>;
        return todos.map((todo) => Task.fromJson(todo)).toList();
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (error) {
      _handleError('Get tasks by user ID', error);
      return [];
    }
  }

  Future<Task?> addTask(String todo, bool completed, int userId) async {
    try {
      final response = await ApiHelper.postRequest('$baseUrl/add', {
        'todo': todo,
        'completed': completed,
        'userId': userId,
      });
      final responseData = ApiHelper.handleResponse(response);
      if (responseData != null) {
        return Task.fromJson(responseData);
      } else {
        throw Exception('Failed to add task');
      }
    } catch (error) {
      _handleError('Add task', error);
      return null;
    }
  }

  Future<Task?> updateTask(int id, bool completed) async {
    try {
      final response = await ApiHelper.putRequest('$baseUrl/$id', {
        'completed': completed,
      });
      final responseData = ApiHelper.handleResponse(response);
      if (responseData != null) {
        return Task.fromJson(responseData);
      } else {
        throw Exception('Failed to update task status');
      }
    } catch (error) {
      _handleError('Update task', error);
      return null;
    }
  }

  Future<Task?> deleteTask(int id) async {
    try {
      final response = await ApiHelper.deleteRequest('$baseUrl/$id');
      final responseData = ApiHelper.handleResponse(response);
      if (responseData != null) {
        return Task.fromJson(responseData);
      } else {
        throw Exception('Failed to delete task');
      }
    } catch (error) {
      _handleError('Delete task', error);
      return null;
    }
  }

  void _handleError(String operation, dynamic error) {
    if (error is ServerFailures) {
      print('$operation failed: ${error.errorMessage}');
    } else {
      print('$operation failed: $error');
    }
  }
}
