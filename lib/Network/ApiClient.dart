import 'package:education_app/Model/LoginResponse.dart';
import 'package:education_app/Model/SignUpResponse.dart';
import 'package:education_app/Model/Video.dart';
import 'package:education_app/Network/Login.dart';
import 'package:education_app/Network/SignUp.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'ApiClient.g.dart';

@RestApi(baseUrl: "http://arnabbhadra29.pythonanywhere.com")
abstract class ApiClient {
  factory ApiClient(Dio dio) {
    dio.options = BaseOptions(receiveTimeout: 50000, connectTimeout: 50000);
    return _ApiClient(dio, baseUrl: "http://arnabbhadra29.pythonanywhere.com");
  }

  @POST("/signup")
  Future<SignUpResponse> signUpUser(@Body() SignUp signUp);

  @POST("/login")
  Future<LoginResponse> loginUser(@Body() Login login);

  @GET("/getAllVideo")
  Future<Videos> getVideos();
}
