import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Bloc/Repository.dart';
import 'package:education_app/Model/profile_response.dart';
import 'package:education_app/Network/ApiClient.dart';
import 'package:education_app/Network/profile_request.dart';
import 'package:hive/hive.dart';

class ProfileBloc extends Bloc {
  final _controller = StreamController<ProfileResponse>();

  Stream get profileStrem => _controller.stream;

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
        _controller.sink.add(profileResponse);
      }
    } catch (error) {
      print("Error getting profile: " + error.toString());
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
