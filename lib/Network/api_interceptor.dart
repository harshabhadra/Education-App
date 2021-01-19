import 'package:dio/dio.dart';
import 'package:education_app/Model/error_model.dart';
import 'package:education_app/Model/error_type.dart';
import 'package:hive/hive.dart';

class ApiInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    if (!(options.path == '/signup') ||
        !(options.path == '/login') ||
        (options.path == '/studentInfo') ||
        (options.path == '/refreshToken')) {
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
    // print("response data: " + response.data.toString());
    // print("response status message : " + response.statusMessage);
    // print("respon status code: " + response.statusCode.toString());

    return response;
  }

  @override
  Future onError(DioError error) async {
    print("Error : " + error.response.toString());
    print("Error type: " + error.type.toString());
    print("Error message: " + error.message);

    var errorModel = ErrorModel(
        title: "", errorType: ErrorType.Unknown, description: error.message);
    return errorModel;
  }
}
