import 'dart:convert';
import 'package:dio/dio.dart';
import 'api_error_handler.dart';
import '../data/data_manager.dart';

class ApiHelper {
  static final Dio _dio = Dio();

  static Future<Response> postRequest(String url, Map<String, dynamic> body,
      [String? token]) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      return await _dio.post(
        url,
        options: Options(headers: headers),
        data: jsonEncode(body),
      );
    } catch (e) {
      throw ServerFailures(errorMessage: 'Failed to perform POST request: $e');
    }
  }

  static Future<Response> getRequest(String url) async {
    final token = await DataManager.getToken();
    final headers = {'Authorization': 'Bearer $token'};

    try {
      return await _dio.get(
        url,
        options: Options(headers: headers),
      );
    } catch (e) {
      throw ServerFailures(errorMessage: 'Failed to perform GET request: $e');
    }
  }

  static Future<Response> putRequest(String url, Map<String, dynamic> body,
      [String? token]) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      return await _dio.put(
        url,
        options: Options(headers: headers),
        data: jsonEncode(body),
      );
    } catch (e) {
      throw ServerFailures(errorMessage: 'Failed to perform PUT request: $e');
    }
  }

  static Future<Response> deleteRequest(String url, [String? token]) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      return await _dio.delete(
        url,
        options: Options(headers: headers),
      );
    } catch (e) {
      throw ServerFailures(
          errorMessage: 'Failed to perform DELETE request: $e');
    }
  }

  static dynamic handleResponse(Response response) {
    if (response.statusCode == 200) {
      final responseData = response.data;
      return responseData;
    } else {
      return null;
    }
  }
}
