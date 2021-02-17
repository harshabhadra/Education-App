import 'dart:convert';
import 'package:dio/dio.dart';

class PaymentInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    String username = 'rzp_live_bk1vdOGpC2v8Dy';
  String password = 'nN1JtG2Vv1hZe0UReSJ2S9lH';
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
