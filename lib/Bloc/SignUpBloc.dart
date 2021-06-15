import 'dart:async';
import 'package:dio/dio.dart';
import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Model/SignUpResponse.dart';
import 'package:education_app/Network/ApiClient.dart';
import 'package:education_app/Network/SignUp.dart';

class SignUpBloc implements Bloc {
  final _controller = StreamController<SignUpResponse>();

  Stream get signUpStream => _controller.stream;

  void signUp(String email, String password, Dio dio) async {
    ApiClient apiClient = ApiClient(dio);
    SignUpResponse signUpResponse;
    SignUp signUp = SignUp(email: email, password: password);
    try {
      print("sign up email:${email}, password: ${password}");
      signUpResponse = await apiClient.signUpUser(signUp);
      print(
          "sign up response in bloc: ${signUpResponse.toJson().toString()}");
      _controller.sink.add(signUpResponse);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
