import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Model/LoginResponse.dart';
import 'package:education_app/Model/error_model.dart';
import 'package:education_app/Network/ApiClient.dart';
import 'package:education_app/Network/Login.dart';
import 'package:education_app/database/DatabaseLogin.dart';
import 'package:hive/hive.dart';
import 'package:retrofit/dio.dart';

class LoginBloc implements Bloc {
  final _controller = StreamController<LoginResponse>();

  Stream get loginStream => _controller.stream;

  void login(String email, String password) async {
    Dio dio = Dio();
    ApiClient apiClient = ApiClient(dio);
    var box = Hive.box('user');
    var credBox = Hive.box('cred');
    LoginResponse loginResponse;
    Login login = Login(email: email, password: password);

    try {
      var value = await apiClient.loginUser(login);
      print("log in response: " + value.response.data);

      Map<String, dynamic> body = json.decode(value.response.data);
      if (body.containsKey('customToken')) {
        loginResponse = LoginResponse.fromJson(body);
      } else {
        ErrorModel errorModel = value.response.data;
        print('Log in error: ' + errorModel.description);
      }
      // Save cred in hive if log in is successful
      if (loginResponse.detailPresent && loginResponse.statusCode == 100) {
        if (box.isEmpty) {
          box.add(DatabaseLogin(email: email, password: password));
        } else {
          box.clear();
          box.add(DatabaseLogin(email: email, password: password));
        }

        if (credBox.isEmpty) {
          credBox.put('email', email);
          credBox.put('token', loginResponse.customToken);
          credBox.put('refreshToken', loginResponse.refreshToken);
        } else {
          credBox.delete('email');
          credBox.delete('token');
          credBox.delete('refreshToken');
          credBox.put('email', email);
          credBox.put('token', loginResponse.customToken);
          credBox.put('refreshToken', loginResponse.refreshToken);
        }
      }
      print(loginResponse.message.toString());

      //Add login response to streamController
      _controller.add(loginResponse);
    } on Exception catch (e) {
      print('Log in exception: ' + e.toString());
    
    } catch (error) {}
  }

  @override
  void dispose() {
    _controller.close();
  }
}
