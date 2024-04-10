import '../../utils/api_helper.dart';
import '../models/task.dart';

class TaskRepository {
  static const String baseUrl = 'https://dummyjson.com/todos';

  Future<List<Task>> getAllTasks({int limit = 0, int skip = 0}) async {
    final response =
        await ApiHelper.getRequest('$baseUrl?limit=$limit&skip=$skip');
    final responseData = ApiHelper.handleResponse(response);
    if (responseData != null) {
      final todos = responseData['todos'] as List<dynamic>;
      return todos.map((todo) => Task.fromJson(todo)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task> getTaskById(int id) async {
    final response = await ApiHelper.getRequest('$baseUrl/$id');
    final responseData = ApiHelper.handleResponse(response);
    if (responseData != null) {
      return Task.fromJson(responseData);
    } else {
      throw Exception('Failed to load task');
    }
  }

  Future<List<Task>> getTasksByUserId(int userId) async {
    final response = await ApiHelper.getRequest('$baseUrl/user/$userId');
    final responseData = ApiHelper.handleResponse(response);
    if (responseData != null) {
      final todos = responseData['todos'] as List<dynamic>;
      return todos.map((todo) => Task.fromJson(todo)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task> addTask(String todo, bool completed, int userId) async {
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
  }

  Future<Task> updateTask(int id, bool completed) async {
    final response = await ApiHelper.putRequest('$baseUrl/$id', {
      'completed': completed,
    });
    final responseData = ApiHelper.handleResponse(response);
    if (responseData != null) {
      return Task.fromJson(responseData);
    } else {
      throw Exception('Failed to update task status');
    }
  }

  Future<Task> deleteTask(int id) async {
    final response = await ApiHelper.deleteRequest('$baseUrl/$id');
    final responseData = ApiHelper.handleResponse(response);
    if (responseData != null) {
      return Task.fromJson(responseData);
    } else {
      throw Exception('Failed to delete task');
    }
  }
}
