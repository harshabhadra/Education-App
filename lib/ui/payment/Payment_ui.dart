import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/Bloc/payment_bloc.dart';
import 'package:education_app/Model/pay_response.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentUi extends StatefulWidget {
  PaymentUi({Key key}) : super(key: key);

  @override
  _PaymentUiState createState() => _PaymentUiState();
}

class _PaymentUiState extends State<PaymentUi> {
  Razorpay _razorpay;
  final bloc = PaymentBloc();

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: kPrimaryColor,
      ),
      body: BlocProvider(
        bloc: bloc,
        child: Container(
          child: _buildResult(bloc),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openCheckout();
        },
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("SUCCESS: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("ERROR: ${response.code.toString()} , message: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("EXTERNAL_WALLET: ${response.walletName}");
  }

  void openCheckout() async {
    var options = {
      'key': '',
      'amount': 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
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
            return Center(
              child: Text("Order Id: ${snapdata.data.id}"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}
