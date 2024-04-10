import '../../utils/api_helper.dart';
import '../models/task.dart';

class TaskRepository {
  static const String baseUrl = 'https://dummyjson.com/todos';

  Future<List<Task>> getAllTasks() async {
    final response = await ApiHelper.getRequest(baseUrl, 'your_token_here');
    final responseData = ApiHelper.handleResponse(response);
    if (responseData != null) {
      final todos = responseData['todos'] as List<dynamic>;
      return todos.map((todo) => Task.fromJson(todo)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task> getTaskById(int id) async {
    final response =
        await ApiHelper.getRequest('$baseUrl/$id', 'your_token_here');
    final responseData = ApiHelper.handleResponse(response);
    if (responseData != null) {
      return Task.fromJson(responseData);
    } else {
      throw Exception('Failed to load task');
    }
  }

  Future<List<Task>> getTasksByUserId(int userId) async {
    final response =
        await ApiHelper.getRequest('$baseUrl/user/$userId', 'your_token_here');
    final responseData = ApiHelper.handleResponse(response);
    if (responseData != null) {
      final todos = responseData['todos'] as List<dynamic>;
      return todos.map((todo) => Task.fromJson(todo)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task> addTask(String todo, bool completed, int userId) async {
    final response = await ApiHelper.postRequest(
        '$baseUrl/add',
        {
          'todo': todo,
          'completed': completed,
          'userId': userId,
        },
        'your_token_here');
    final responseData = ApiHelper.handleResponse(response);
    if (responseData != null) {
      return Task.fromJson(responseData);
    } else {
      throw Exception('Failed to add task');
    }
  }

  Future<Task> updateTaskStatus(int id, bool completed) async {
    final response = await ApiHelper.putRequest(
        '$baseUrl/$id',
        {
          'completed': completed,
        },
        'your_token_here');
    final responseData = ApiHelper.handleResponse(response);
    if (responseData != null) {
      return Task.fromJson(responseData);
    } else {
      throw Exception('Failed to update task status');
    }
  }

  Future<Task> deleteTask(int id) async {
    final response =
        await ApiHelper.deleteRequest('$baseUrl/$id', 'your_token_here');
    final responseData = ApiHelper.handleResponse(response);
    if (responseData != null) {
      return Task.fromJson(responseData);
    } else {
      throw Exception('Failed to delete task');
    }
  }
}
