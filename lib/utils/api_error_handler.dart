import 'package:dio/dio.dart';

abstract class Failures {
  final String errorMessage;

  Failures({required this.errorMessage});
}

class ServerFailures extends Failures {
  ServerFailures({required super.errorMessage});

  factory ServerFailures.ServerFailures(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailures(errorMessage: 'Connection timeout with api');

      case DioExceptionType.sendTimeout:
        return ServerFailures(errorMessage: 'Send timeout with api');

      case DioExceptionType.receiveTimeout:
        return ServerFailures(errorMessage: 'Receive timeout with api');

      case DioExceptionType.badCertificate:
        return ServerFailures.fromResponse(
            response: dioException.response!.data,
            statusCode: dioException.response!.statusCode!);
      case DioExceptionType.badResponse:
        return ServerFailures(errorMessage: 'Error pls try again');

      case DioExceptionType.cancel:
        return ServerFailures(errorMessage: 'The requise canceld');

      case DioExceptionType.connectionError:
        return ServerFailures(errorMessage: 'Bad connection');

      case DioExceptionType.unknown:
        return ServerFailures(errorMessage: 'There is no internet');
    }
  }

  factory ServerFailures.fromResponse(
      {required dynamic response, required int statusCode}) {
    if (statusCode == 401) {
      return ServerFailures(errorMessage: 'Token expired. Please refresh.');
    } else if (statusCode == 400 || statusCode == 403) {
      return ServerFailures(errorMessage: response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailures(errorMessage: "The session has timed out");
    } else if (statusCode == 500) {
      return ServerFailures(
          errorMessage: "Internal server error, Please try again later");
    } else {
      return ServerFailures(errorMessage: "Server error, please try again later");
    }
  }
}