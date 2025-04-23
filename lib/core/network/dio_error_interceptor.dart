import 'package:dio/dio.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage;

    if (err.response != null) {
      if (err.response!.statusCode! >= 300) {
        errorMessage = err.response!.data['message'] ?? err.response!.statusMessage!;
      } else {
        errorMessage = 'Something went wrong';
      }
    } else {
      // Handle connection errors
      errorMessage = 'Connection error!';
    }

    // Log the error to console or a remote monitoring service
    print('Error: $errorMessage');
    print('Error Type: ${err.type}');
    print('Request Path: ${err.requestOptions.path}');

    // Update the error message in the response
    err = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      error: errorMessage,
      type: err.type,
    );

    super.onError(err, handler);
  }
}
