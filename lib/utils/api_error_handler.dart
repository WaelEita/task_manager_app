import 'package:dio/dio.dart';
import '../data/repositories/authentication_repository.dart';

class ApiErrorHandler {
  static dynamic handleHttpError(int? statusCode) {
    if (statusCode != null) {
      switch (statusCode) {
        case 400:
          return 'Bad request';
        case 401:
          _refreshSession();
          return 'Unauthorized';
        case 403:
          return 'Forbidden';
        case 404:
          return 'Not found';
        case 408:
          return 'Request timeout';
        case 500:
          return 'Internal server error';
        case 502:
          return 'Bad gateway';
        case 503:
          return 'Service unavailable';
        case 504:
          return 'Gateway timeout';
        default:
          return 'Unexpected error';
      }
    } else {
      return 'Unexpected error';
    }
  }

  static void handleDioError(DioError e) {
    if (e.response != null) {
      final response = e.response!;
      final statusCode = response.statusCode;
      final errorMessage = handleHttpError(statusCode);
      print('HTTP Error: $statusCode - $errorMessage');
    } else {
      // Handle other Dio errors (e.g., DioErrorType.connectTimeout)
      print('Dio Error: ${e.message}');
    }
  }

  static void _refreshSession() async {
    try {
      await AuthRepository().refreshSession();
      print('Session refreshed successfully. Retry the failed request.');
    } catch (e) {
      print('Error refreshing session: $e');
    }
  }
}
