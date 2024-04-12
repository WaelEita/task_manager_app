import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/task.dart';

class DataManager {
  static const String _tokenKey = 'authToken';
  static const String _tasksKey = 'tasks';

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskJsonList = tasks.map((task) => task.toJson()).toList();
    await prefs.setStringList(
        _tasksKey, taskJsonList.map((json) => jsonEncode(json)).toList());
  }

  static Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskJsonList = prefs.getStringList(_tasksKey);
    if (taskJsonList != null) {
      return taskJsonList
          .map((json) => Task.fromJson(jsonDecode(json)))
          .toList();
    } else {
      return [];
    }
  }
}
