import 'dart:io';
import 'package:education_app/Model/pay_response.dart';
import 'package:education_app/Network/payment_request.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'payment_Client.g.dart';

@RestApi(baseUrl: "https://api.razorpay.com/v1/")
abstract class PaymentClient {
  factory PaymentClient(Dio dio) {
    dio.options = BaseOptions(receiveTimeout: 50000, connectTimeout: 50000);
    dio.options.headers['Authorization'] =
        "Basic $HttpClientBasicCredentials('rzp_test_nsF8Nu1mu2MKaT', 'tBfJ3ZwSMmTgLj6oUCy0zLZ9')";
    return _PaymentClient(dio);
  }

  @POST('/orders')
  Future<String> paySubs(@Body() PayRequest paymentRequest);
}
