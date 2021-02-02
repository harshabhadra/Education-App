import 'dart:async';
import 'dart:convert';
import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Bloc/Repository.dart';
import 'package:education_app/Model/profile_response.dart';
import 'package:education_app/Network/ApiClient.dart';
import 'package:education_app/Network/profile_request.dart';
import 'package:education_app/Network/sub_request.dart';
import 'package:education_app/Network/update_profile_request.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class SubscriptionBloc extends Bloc {
  final _controller = StreamController<Map<String, dynamic>>();
  final _subsController = StreamController<Map<String, dynamic>>();
  final _subDController = StreamController<Map<String, dynamic>>();
  final _studentControllr = StreamController<Map<String, dynamic>>();
  final _pRcontroller = StreamController<ProfileResponse>();

  Stream get planStream => _controller.stream;
  Stream get subsStream => _subsController.stream;
  Stream get subDStream => _subDController.stream;
  Stream get studentInfoStream => _studentControllr.stream;
  Stream get profileStream => _pRcontroller.stream;

  Repository _repository = Repository();
  void getPlans() async {
    var map = await _repository.getPlans();
    _controller.sink.add(map);
  }

  void createSubscription(SubsRequest subsRequest) async {
    var map = await _repository.createSubscription(subsRequest);
    _subsController.sink.add(map);
  }

  void getSubcription(String subId) async {
    var map = await _repository.getSubcription(subId);
    _subDController.sink.add(map);
  }

  void updateStudentInfo(UpdateProfileRequest updateProfileRequest) async {
    await _repository.refreshToken().whenComplete(() {
      _updateProfile(updateProfileRequest);
    });
  }

  void _updateProfile(UpdateProfileRequest updateProfileRequest) async {
    var map = await _repository.updateProfile(updateProfileRequest);
    _studentControllr.sink.add(map);
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
        _pRcontroller.sink.add(profileResponse);
      }
    } catch (error) {
      print("Error getting profile: " + error.toString());
    }
  }

  @override
  void dispose() {
    _subsController.close();
    _subDController.close();
    _studentControllr.close();
    _controller.close();
    _pRcontroller.close();
  }
}
