import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Bloc/Repository.dart';
import 'package:education_app/Model/LoginResponse.dart';
import 'package:education_app/Model/error_model.dart';
import 'package:education_app/Model/profile_response.dart';
import 'package:education_app/Network/ApiClient.dart';
import 'package:education_app/Network/Login.dart';
import 'package:education_app/Network/profile_request.dart';
import 'package:education_app/database/DatabaseLogin.dart';
import 'package:hive/hive.dart';

class LoginBloc implements Bloc {
  final _controller = StreamController<LoginResponse>.broadcast();
  final _profileController = StreamController<ProfileResponse>.broadcast();
  final _sController = StreamController<Map<String, dynamic>>();

  Stream get loginStream => _controller.stream.asBroadcastStream();
  Stream get profileStream => _profileController.stream.asBroadcastStream();
  Stream get subStream => _sController.stream;

  void login(String email, String password) async {
    Dio dio = Dio();
    ApiClient apiClient = ApiClient(dio);
    var box = Hive.box('user');
    var credBox = Hive.box('cred');
    LoginResponse loginResponse;
    Login login = Login(email: email, password: password);

    try {
      print("input email: ${email}, password: ${password}");
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
          credBox.put('loginResponse', loginResponse);
        } else {
          credBox.delete('email');
          credBox.delete('token');
          credBox.delete('refreshToken');
          credBox.delete('loginResponse');

          credBox.put('email', email);
          credBox.put('token', loginResponse.customToken);
          credBox.put('refreshToken', loginResponse.refreshToken);
          credBox.put('loginResponse', loginResponse);
        }
      }
      print(loginResponse.message.toString());

      //Add login response to streamController
      _controller.add(loginResponse);
    } on Exception catch (e) {
      print('Log in exception: ' + e.toString());
    } catch (error) {}
  }

  void getProfile() async {
    Repository repository = Repository();
    await repository.refreshToken().whenComplete(() => getProfileData());
  }

  void getProfileData() async {
    Dio dio = Dio();
    ApiClient apiClient = ApiClient(dio);
    var credBox = Hive.box('cred');
    ProfileResponse profileResponse;

    try {
      String email = credBox.get('email');
      ProfileRequest profileRequest = ProfileRequest(email: email);
      var response = await apiClient.getStudentProfile(profileRequest.toJson());
      print("profile response: " + response.response.data.toString());
      Map<String, dynamic> resMap = json.decode(response.response.data);
      if (resMap.containsKey('studentInfo')) {
        profileResponse = ProfileResponse.fromJson(resMap);
        _profileController.sink.add(profileResponse);
      }
    } catch (error) {
      print("Error getting profile: " + error.toString());
    }
  }

  void getSubcription(String subId) async {
    Repository _repository = Repository();
    var map = await _repository.getSubcription(subId);
    _sController.sink.add(map);
  }

  @override
  void dispose() {
    _controller.close();
    _profileController.close();
    _sController.close();
  }
}
