import 'dart:async';
import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Bloc/Repository.dart';
import 'package:education_app/Model/student_info_response.dart';
import 'package:dio/dio.dart';
import 'package:education_app/Network/ApiClient.dart';
import 'package:education_app/Network/studentinfo.dart';
import 'package:hive/hive.dart';

class StudentInfoBloc implements Bloc {
  final _controller = StreamController<StudentInfoResponse>();

  Stream<StudentInfoResponse> get studentInfoStream => _controller.stream;

  void setStudentInfo(StudentInfo studentInfo) async {
    Dio dio = Dio();
    ApiClient apiClient = ApiClient(dio);
    StudentInfoResponse studentInfoResponse;

    try {
      await apiClient.setStudentInfo(studentInfo).then((value) {
        studentInfoResponse = value;
        _controller.sink.add(studentInfoResponse);
      });
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
