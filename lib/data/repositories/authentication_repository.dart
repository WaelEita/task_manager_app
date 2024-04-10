import '../../utils/api_helper.dart';
import '../models/user.dart';

class AuthRepository {
  static const String baseUrl = 'https://dummyjson.com/auth';

  Future<User?> loginUser(String username, String password) async {
    final response = await ApiHelper.postRequest('$baseUrl/login', {
      'username': username,
      'password': password,
    });

    return _handleResponse(response);
  }

  Future<User?> getCurrentUser() async {
    final response = await ApiHelper.getRequest('$baseUrl/me');
    return _handleResponse(response);
  }

  Future<User?> refreshSession() async {
    final response = await ApiHelper.postRequest('$baseUrl/refresh', {});
    return _handleResponse(response);
  }

  User? _handleResponse(dynamic response) {
    if (response != null) {
      return User.fromJson(response);
    } else {
      return null;
    }
  }
}
