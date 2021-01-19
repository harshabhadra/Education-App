import 'package:education_app/Model/SignUpResponse.dart';
import 'package:education_app/Model/Video.dart';
import 'package:education_app/Model/books_model.dart';
import 'package:education_app/Model/student_info_response.dart';
import 'package:education_app/Network/Login.dart';
import 'package:education_app/Network/SignUp.dart';
import 'package:education_app/Network/api_interceptor.dart';
import 'package:education_app/Network/questions_request.dart';
import 'package:education_app/Network/studentinfo.dart';
import 'package:education_app/Network/submit_test_request.dart';
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

  @POST("/getAllVideo")
  Future<HttpResponse<String>> getVideos(@Body() String videoRequest);

  @POST("/getBookInfo")
  Future<Books> getBooks(@Body() String bookRequest);

  @POST("/studentInfo")
  Future<StudentInfoResponse> setStudentInfo(@Body() StudentInfo studentInfo);

  @GET("/getAllExamInfo")
  Future<HttpResponse<String>> getAllExamInfo();

  @POST("/refreshToken")
  Future<HttpResponse<String>> refreshToken(@Body() String refreshTokenRequest);

  @POST("/getStudentInfo")
  Future<HttpResponse<String>> getStudentProfile(@Body() String profileRequest);

  @POST("/getAllQuestionByExam")
  Future<HttpResponse<String>> getQuestions(
      @Body() QuestionsRequest questionRequest);

  @POST("/storeResponse")
  Future<HttpResponse<String>> submitTestResults(
      @Body() SubmitTestRequest submitTestRequest);
}
