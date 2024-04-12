import '../../utils/api_error_handler.dart';
import '../../utils/api_helper.dart';
import '../data_manager.dart';
import '../models/user.dart';

class AuthRepository {
  static const String baseUrl = 'https://dummyjson.com/auth';

  Future<User?> loginUser(String username, String password) async {
    try {
      final response = await ApiHelper.postRequest('$baseUrl/login', {
        'username': username,
        'password': password,
      });
      final responseData = ApiHelper.handleResponse(response);
      if (responseData != null) {
        await DataManager.saveToken(responseData['token']);
        return User.fromJson(responseData);
      } else {
        return null;
      }
    } catch (error) {
      _handleError('Login', error);
      return null;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final response = await ApiHelper.getRequest('$baseUrl/me');
      return ApiHelper.handleResponse(response) != null
          ? User.fromJson(ApiHelper.handleResponse(response))
          : null;
    } catch (error) {
      _handleError('Get current user', error);
      return null;
    }
  }

  Future<User?> refreshSession() async {
    try {
      final response = await ApiHelper.postRequest('$baseUrl/refresh', {});
      return ApiHelper.handleResponse(response) != null
          ? User.fromJson(ApiHelper.handleResponse(response))
          : null;
    } catch (error) {
      _handleError('Refresh session', error);
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
