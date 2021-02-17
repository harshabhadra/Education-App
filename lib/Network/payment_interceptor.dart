import 'dart:convert';
import 'package:dio/dio.dart';

class PaymentInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    String username = '';
  String password = '';
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
    options.headers['authorization'] = basicAuth;
    return options;
  }

  @override
  Future onResponse(Response response) async {
    return response;
  }

  @override
  Future onError(DioError error) async {
    return error;
  }
}
