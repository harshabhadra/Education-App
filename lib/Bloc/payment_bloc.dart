import 'dart:async';
import 'package:dio/dio.dart';
import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Model/pay_response.dart';
import 'package:education_app/Network/payment_Client.dart';
import 'package:education_app/Network/payment_request.dart';

class PaymentBloc implements Bloc {
  final _controller = StreamController<PayResponse>();

  Stream get payStream => _controller.stream;

  void getOrderId(int amount) async {
    Dio dio = Dio();
    PaymentClient _paymentClient = PaymentClient(dio);
    String response;

    try {
      response = await _paymentClient
          .paySubs(PayRequest(amount: amount, currency: "INR", receipt: ""))
          .whenComplete(() => print(response))
          .catchError((error) {
               switch (error.runtimeType) {
          case DioError:
            final res = (error as DioError).response;
            print(
                "Error status: ${res.statusCode}, Error messsage: ${res.statusMessage}");
            _controller.addError(error);
            break;
        }
          });
    } catch (error) {
      print("Exception in payment: $error");
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
