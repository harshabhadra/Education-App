import 'dart:async';
import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Model/student_info_response.dart';
import 'package:dio/dio.dart';
import 'package:education_app/Network/ApiClient.dart';
import 'package:education_app/Network/studentinfo.dart';

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
      }).catchError((error) {
        switch (error.runtimeType) {
          case DioError:
            final res = (error as DioError).response;
            print(
                "Error status: ${res.statusCode}, Error messsage: ${res.statusMessage}");
            _controller.addError(error);
            break;
        }
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
