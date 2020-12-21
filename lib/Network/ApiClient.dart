import 'package:education_app/Model/LoginResponse.dart';
import 'package:education_app/Model/SignUpResponse.dart';
import 'package:education_app/Model/Video.dart';
import 'package:education_app/Model/books_model.dart';
import 'package:education_app/Model/exam_info.dart';
import 'package:education_app/Model/student_info_response.dart';
import 'package:education_app/Network/Login.dart';
import 'package:education_app/Network/SignUp.dart';
import 'package:education_app/Network/api_interceptor.dart';
import 'package:education_app/Network/studentinfo.dart';
import 'package:http/http.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'ApiClient.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) {
    dio.options = BaseOptions(receiveTimeout: 50000, connectTimeout: 50000);
    dio.interceptors.add(ApiInterceptor());
    return _ApiClient(dio, baseUrl: "http://arnabbhadra29.pythonanywhere.com");
  }

  @POST("/signup")
  Future<SignUpResponse> signUpUser(@Body() SignUp signUp);

  @POST("/login")
  Future<HttpResponse<String>> loginUser(@Body() Login login);

  @GET("/getAllVideo")
  Future<Videos> getVideos();

  @GET("/getBookInfo")
  Future<Books> getBooks();

  @POST("/studentInfo")
  Future<StudentInfoResponse> setStudentInfo(@Body() StudentInfo studentInfo);

  @GET("/getAllExamInfo")
  Future<HttpResponse<String>> getAllExamInfo();
}
