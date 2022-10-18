import 'package:dio/dio.dart';


class APIRequest {
  final String url;
  final Map<String, dynamic>? payLoad;

  APIRequest({required this.url, this.payLoad});


  Dio _dio() {
    return Dio(BaseOptions(headers: {
      'Content-Type': 'application/json'
    }, baseUrl: "https://jsonplaceholder.typicode.com"));
  }

  void get(
      {Function()? beforeSend,
        Function(dynamic data)? onSuccess,
        Function(dynamic error)? onError}) {
    _dio().get(url, queryParameters: payLoad).then((response) {
      if (onSuccess != null) {
        onSuccess(response.data);
      }
    }).catchError((error) {
      if (onError != null) {
        onError(error);
      }
    });
  }

  void post(
      {Function()? beforeSend,
        Function(dynamic data)? onSuccess,
        Function(dynamic error)? onError}) {
    _dio().post(url, data: payLoad).then((response) {
      if (onSuccess != null) {
        onSuccess(response.data);
      }
    }).catchError((error) {
      if (onError != null) {
        onError(error);
      }
    });
  }
}
