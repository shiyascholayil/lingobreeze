import 'dart:io';
import 'package:dio/dio.dart';

class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Connection timeout. Please check your internet connection.';
        case DioExceptionType.connectionError:
          return 'Unable to connect to the server. Please check your connection.';
        case DioExceptionType.badResponse:
          if (error.response?.statusCode == 400) {
            return 'Invalid data. Please check your input.';
          } else if (error.response?.statusCode == 404) {
            return 'Requested resource not found.';
          } else if (error.response?.statusCode == 500) {
            return 'Server error. Please try again later.';
          }
          return 'Something went wrong. Please try again.';
        default:
          return 'An unexpected error occurred. Please try again.';
      }
    } else if (error is SocketException) {
      return 'No internet connection. Please check your network.';
    }
    return 'Something went wrong. Please try again.';
  }
}