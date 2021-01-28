import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class PaymentInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    String username = 'rzp_test_tEP3lsuIxaAzIJ';
  String password = 'i8zSBQ0vRfnMi31DoJllgDty';
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
