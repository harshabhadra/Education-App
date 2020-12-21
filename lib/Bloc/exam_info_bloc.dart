import 'dart:async';
import 'dart:convert';

import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Bloc/Repository.dart';
import 'package:education_app/Model/error_model.dart';
import 'package:education_app/Model/error_type.dart';
import 'package:education_app/Model/exam_info.dart';
import 'package:dio/dio.dart';
import 'package:education_app/Network/ApiClient.dart';

class ExamInfoBloc extends Bloc {
  final _controller = StreamController<Map<String, dynamic>>();

  Stream get examInfoStream => _controller.stream;

  void getExamInfo() async {
    Map<String, dynamic> map = new Map<String, dynamic>();
    ExamInfo exam;
    ErrorModel errorModel;
    //Initializing Dio
    Dio dio = Dio();
    ApiClient apiClient = ApiClient(dio);
    try {
      var response = await apiClient.getAllExamInfo();
      Map<String, dynamic> body = json.decode(response.data);
      if (body.containsKey('examList')) {
        exam = ExamInfo.fromJson(body);
        map['exam'] = exam;
        map['error'] = null;
        _controller.sink.add(map);
      } else if (body.containsKey('message')) {
        String message = body['message'];
        errorModel = ErrorModel(
            title: "API Error",
            description: message,
            errorType: ErrorType.APIError);
        map['exam'] = null;
        map['error'] = errorModel;
          _controller.sink.add(map);
      } else {
        errorModel = ErrorModel(
            title: "Unknown",
            description: "Unknown",
            errorType: ErrorType.Unknown);
        map['exam'] = null;
        map['error'] = errorModel;
          _controller.sink.add(map);
      }
    } catch (error) {
      print("Exam info error: " + error.toString());
    }
  }

  @override
  void dispose() {
    _controller.close();
    // TODO: implement dispose
  }
}
