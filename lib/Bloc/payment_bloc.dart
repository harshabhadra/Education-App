import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Bloc/Repository.dart';
import 'package:education_app/Model/pay_response.dart';
import 'package:education_app/Model/profile_response.dart';
import 'package:education_app/Model/purchase_book_response.dart';
import 'package:education_app/Network/ApiClient.dart';
import 'package:education_app/Network/payment_Client.dart';
import 'package:education_app/Network/payment_request.dart';
import 'package:education_app/Network/profile_request.dart';
import 'package:education_app/Network/purchase_book_request.dart';
import 'package:hive/hive.dart';

class PaymentBloc implements Bloc {
  final _controller = StreamController<PayResponse>();

  final _bookController = StreamController<Map<String, dynamic>>();

  final _pController = StreamController<ProfileResponse>();

  Repository _repository = Repository();

  Stream get payStream => _controller.stream;
  Stream get bookStream => _bookController.stream;
  Stream get profileStream => _pController.stream;

  void getOrderId(int amount) async {
    Dio dio = Dio();
    PaymentClient _paymentClient = PaymentClient(dio);
    PayResponse response;

    try {
      response = await _paymentClient
          .paySubs(PayRequest(amount: amount, currency: "INR"));
      _controller.sink.add(response);
    } catch (error) {
      print("Exception in payment: $error");
    }
  }

  void purchaseBook(int bookId) async {
    await _repository.refreshToken().whenComplete(() {
      _addPurchase(bookId);
    });
  }

  void _addPurchase(int bookId) async {
    Map<String, dynamic> map = new Map<String, dynamic>();
    var credBox = Hive.box('cred');
    String email = credBox.get('email');
    var request = PurchaseBookRequest(bookId: bookId, email: email);
    map = await _repository.addPurchase(request);
    _bookController.sink.add(map);
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
        _pController.sink.add(profileResponse);
      }
    } catch (error) {
      print("Error getting profile: " + error.toString());
    }
  }

  @override
  void dispose() {
    _controller.close();
    _bookController.close();
    _pController.close();
  }
}
