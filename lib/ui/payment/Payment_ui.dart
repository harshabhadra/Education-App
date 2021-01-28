import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/Bloc/payment_bloc.dart';
import 'package:education_app/Model/LoginResponse.dart';
import 'package:education_app/Model/pay_response.dart';
import 'package:education_app/Model/profile_response.dart';
import 'package:education_app/Model/purchase_book_response.dart';
import 'package:education_app/ui/SplashScreen.dart';
import 'package:education_app/ui/home/HomeScreen.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentUi extends StatefulWidget {
  final int price;
  final int bookId;

  PaymentUi({Key key, @required this.price, @required this.bookId})
      : super(key: key);

  @override
  _PaymentUiState createState() => _PaymentUiState();
}

class _PaymentUiState extends State<PaymentUi> {
  Razorpay _razorpay;
  final bloc = PaymentBloc();
  String orderId;
  bool purchaseCompleted;
  ProfileResponse profileResponse;
  LoginResponse loginResponse;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    bloc.getOrderId((widget.price) * 100);
    bloc.payStream.listen((event) {
      PayResponse response = event;
      orderId = response.id;
      openCheckout();
    });
    purchaseCompleted = false;

    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: (!purchaseCompleted)
              ? CircularProgressIndicator()
              : Container(
                  margin: EdgeInsets.only(top: 64),
                  child: Column(
                    children: [
                      Container(
                        height: 180,
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Lottie.asset('assets/raw/book_stack.json',
                              repeat: false),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Purchase Completed',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600)),
                      ),
                      RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 8.0,
                          color: kPrimaryColor,
                          onPressed: () {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return Home(
                                  loginResponse: loginResponse,
                                  profileResponse: profileResponse,
                                );
                              }), (route) => false);
                            });
                          },
                          child: Text(
                            'Go To Home',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("SUCCESS: ${response.paymentId}");
    Dialog _successDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 200,
        child: Column(
          children: [
            Container(
              height: 90,
              width: 90,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Lottie.asset('assets/raw/done.json', repeat: false),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Payment Successful',
                  style: TextStyle(color: Colors.green, fontSize: 18.0)),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _initiatePurchase();
                },
                child: Text('Ok'))
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return _successDialog;
        });
  }

  void _initiatePurchase() {
    bloc.purchaseBook(widget.bookId);
    bloc.bookStream.listen((event) {
      Map<String, dynamic> map = Map();
      map = event;
      if (map.containsKey('statusCode')) {
        PurchaseBookResponse purchaseBookResponse =
            PurchaseBookResponse.fromJson(map);
        if (purchaseBookResponse.statusCode == 100) {
          setState(() {
            _getProfileInfo();
          });
        } else {
          setState(() {
            purchaseCompleted = false;
          });
        }
      }
    });
  }

  void _getProfileInfo() {
    bloc.getProfile();
    bloc.profileStream.listen((event) {
      profileResponse = event;
      var credBox = Hive.box('cred');
      loginResponse = credBox.get('loginResponse');
      setState(() {
        purchaseCompleted = true;
      });
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("ERROR: ${response.code.toString()} , message: ${response.message}");
    Dialog _errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 200,
        child: Column(
          children: [
            Container(
              height: 90,
              width: 90,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Lottie.asset('assets/raw/cancel.json', repeat: false),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${response.message}',
                  style: TextStyle(color: Colors.red, fontSize: 18.0)),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _goBack();
                },
                child: Text('Ok'))
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return _errorDialog;
        });
  }

  void _goBack() {
    setState(() {
      Navigator.of(context).pop();
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("EXTERNAL_WALLET: ${response.walletName}");
  }

  void openCheckout() async {
    int fPrice = (widget.price) * 100;
    var options = {
      'key': 'rzp_test_tEP3lsuIxaAzIJ',
      'amount': fPrice,
      'name': 'AKS Physiology.',
      'order_id': orderId,
      'description': 'Book',
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  Widget _buildResult(PaymentBloc bloc) {
    return StreamBuilder<PayResponse>(
        stream: bloc.payStream,
        builder: (context, snapdata) {
          if (snapdata.connectionState == ConnectionState.active) {
            if (snapdata.hasError) {
              return Center(
                child: Text("Error: ${snapdata.error}"),
              );
            } else if (snapdata.hasData) {
              orderId = snapdata.data.id;
              return Center(
                child: Text("Order Id: ${snapdata.data.id}"),
              );
            } else {
              return Center(
                child: Text("CheckOut Details"),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
