import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/constants/api_endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'dio_error_interceptor.dart';

final httpServiceProvider = Provider.family<Dio, String>(
      (ref, baseUrl) => HttpService(Dio(), baseUrl).dio,
);

class HttpService {
  final Dio _dio;

  Dio get dio => _dio;

  HttpService(this._dio, baseUrl) {
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true,
          // Disable response body logging in production
          // responseBody: false,
          error: true))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }

  HttpService copyWith({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Map<String, dynamic>? headers,
  }) {
    final newDio = Dio(_dio.options.copyWith(
      baseUrl: baseUrl ?? _dio.options.baseUrl,
      connectTimeout: connectTimeout ?? _dio.options.connectTimeout,
      receiveTimeout: receiveTimeout ?? _dio.options.receiveTimeout,
      headers: headers ?? _dio.options.headers,
    ));

    newDio.interceptors.addAll(_dio.interceptors); // Copy interceptors

    return HttpService(newDio, baseUrl ?? _dio.options.baseUrl);
  }
}
