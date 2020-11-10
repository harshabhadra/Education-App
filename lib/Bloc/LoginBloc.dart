import 'dart:async';
import 'package:dio/dio.dart';
import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Model/LoginResponse.dart';
import 'package:education_app/Network/ApiClient.dart';
import 'package:education_app/Network/Login.dart';

class LoginBloc implements Bloc {
  final _controller = StreamController<LoginResponse>();

  Stream get loginStream => _controller.stream;

  void login(String email, String password, Dio dio) async {
    ApiClient apiClient = ApiClient(dio);
    LoginResponse loginResponse;
    Login login = Login(email: email, password: password);
    try {
      loginResponse = await apiClient.loginUser(login);
      _controller.sink.add(loginResponse);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
