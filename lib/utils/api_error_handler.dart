import 'package:dio/dio.dart';

abstract class Failures {
  final String errorMassage;

  Failures({required this.errorMassage});
}

class ServerFailures extends Failures {
  ServerFailures({required super.errorMassage});

  factory ServerFailures.ServerFailures(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailures(errorMassage: 'Connection timeout with api');

      case DioExceptionType.sendTimeout:
        return ServerFailures(errorMassage: 'Send timeout with api');

      case DioExceptionType.receiveTimeout:
        return ServerFailures(errorMassage: 'Receive timeout with api');

      case DioExceptionType.badCertificate:
        return ServerFailures.fromResponse(
            response: dioException.response!.data,
            statusCode: dioException.response!.statusCode!);
      case DioExceptionType.badResponse:
        return ServerFailures(errorMassage: 'Error pls try again');

      case DioExceptionType.cancel:
        return ServerFailures(errorMassage: 'The requise canceld');

      case DioExceptionType.connectionError:
        return ServerFailures(errorMassage: 'Bad connection');

      case DioExceptionType.unknown:
        return ServerFailures(errorMassage: 'There is no internet');
    }
  }

  factory ServerFailures.fromResponse(
      {required dynamic response, required int statusCode}) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailures(errorMassage: response['error']['massage']);
    } else if (statusCode == 404) {
      return ServerFailures(errorMassage: "There is an error 404");
    } else if (statusCode == 500) {
      return ServerFailures(
          errorMassage: "Internal server error, Please try again later");
    } else {
      return ServerFailures(
          errorMassage: "There is an error please try again later");
    }
  }
}
