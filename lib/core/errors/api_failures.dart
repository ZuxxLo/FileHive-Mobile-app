import 'package:dio/dio.dart';
import 'dart:io';

import 'package:filehive/core/errors/api_errors_code.dart';

abstract class DioFailure {
  final String errMessage;
  final String? error;

  const DioFailure({required this.errMessage, this.error});
}

class ApiFailures extends DioFailure {
  ApiFailures({required super.errMessage, super.error});

  factory ApiFailures.fromDioError(DioException dioError) {
    print("*********dui exception 1 ");
    print(dioError.type);
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ApiFailures(errMessage: 'Connection timeout with Server');

      case DioExceptionType.sendTimeout:
        return ApiFailures(errMessage: 'Send timeout with Server');

      case DioExceptionType.receiveTimeout:
        return ApiFailures(errMessage: 'Receive timeout with Server');

      case DioExceptionType.badResponse:
        return ApiFailures.fromResponse(
            dioError.response!.statusCode, dioError.response!.data);
      case DioExceptionType.cancel:
        return ApiFailures(errMessage: 'Request to Server was canceld');

      case DioExceptionType.connectionError:
        print(dioError.error);
        // if (dioError.error != null &&
        //     dioError.error.toString().contains('SocketException')) {
        //   return ApiFailures(errMessage:'No Internet Connection');
        // }

        return ApiFailures(errMessage: 'There is a connection error');
      case DioExceptionType.unknown:
        if (dioError.error == ApiErrorsCode.noInternetConnection) {
          return ApiFailures(
              errMessage: 'There is no internet connection',
              error: ApiErrorsCode.noInternetConnection);
        }
        return ApiFailures(errMessage: 'Unexpected Error, Please try again!');

      default:
        return ApiFailures(
            errMessage: 'Opps There was an Error, Please try again');
    }
  }

  factory ApiFailures.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      print("--------------------------------");
      print(response);
      return ApiFailures(
          errMessage: response["message"], error: response["data"]);
    } else if (statusCode == 404) {
      return ApiFailures(
          errMessage: 'Your request was not found, Please try later!');
    } else if (statusCode == 500) {
      return ApiFailures(errMessage: 'Internal Server error, Please try later');
    } else {
      return ApiFailures(
          errMessage: 'Opps There was an Error, Please try again');
    }
  }
}

class ConnectivityInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("objeConnectivityInterceptorConnectivityInterceptorct");
    if (!await _isInternetAvailable()) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: ApiErrorsCode.noInternetConnection,
          type: DioExceptionType.unknown,
        ),
      );
    } else {
      handler.next(options);
    }
  }

  Future<bool> _isInternetAvailable() async {
    try {
      final url = Uri.parse('http://clients3.google.com/generate_204');
      final httpClient = HttpClient()
        ..connectionTimeout = const Duration(seconds: 5);
      final request = await httpClient.getUrl(url);
      final response = await request.close();
      return response.statusCode == HttpStatus.noContent;
    } on SocketException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }
}
