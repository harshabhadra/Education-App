import 'dart:io';
import 'package:education_app/Model/pay_response.dart';
import 'package:education_app/Network/payment_interceptor.dart';
import 'package:education_app/Network/payment_request.dart';
import 'package:education_app/Network/sub_request.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'payment_Client.g.dart';

@RestApi(baseUrl: "https://api.razorpay.com/v1/")
abstract class PaymentClient {
  factory PaymentClient(Dio dio) {
    dio.options = BaseOptions(receiveTimeout: 50000, connectTimeout: 50000);
    dio.interceptors.add(PaymentInterceptor());
    return _PaymentClient(dio, baseUrl: 'https://api.razorpay.com/v1/');
  }

  @POST('orders')
  Future<PayResponse> paySubs(@Body() PayRequest paymentRequest);

  @GET("plans")
  Future<HttpResponse<String>> getPlans();

  @POST('subscriptions')
  Future<HttpResponse<String>> createSubscription(
      @Body() SubsRequest subsRequest);

  @GET("subscriptions/{id}")
  Future<HttpResponse<String>> getSubciption(@Path() String id);
}
