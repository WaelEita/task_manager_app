import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_manager.dart';

class ApiHelper {
  static Future<http.Response> postRequest(
      String url, Map<String, dynamic> body,
      [String? token]) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> getRequest(String url) async {
    final token = await TokenManager.getToken();
    final headers = {'Authorization': 'Bearer $token'};
    return await http.get(
      Uri.parse(url),
      headers: headers,
    );
  }

  static Future<http.Response> putRequest(String url, Map<String, dynamic> body,
      [String? token]) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> deleteRequest(String url,
      [String? token]) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return await http.delete(
      Uri.parse(url),
      headers: headers,
    );
  }

  static dynamic handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      return null;
    }
  }
}
