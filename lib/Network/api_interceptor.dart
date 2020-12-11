import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class ApiInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    if (!(options.path == '/signup') || !(options.path == '/login') || (options.path == '/studentInfo')) {
      var credBox = Hive.box('cred');
      String email = credBox.get('email');
      String token = credBox.get('token');
      options.headers["email"] = email;
      options.headers["Token"] = token;
    }
    return options;
  }

  @override
  Future onResponse(Response response) async {
    // Do something with response data
  }

  @override
  Future onError(DioError error) async {}
}
