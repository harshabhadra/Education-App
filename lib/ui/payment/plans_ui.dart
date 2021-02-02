import 'package:education_app/Bloc/subscription_bloc.dart';
import 'package:education_app/Model/LoginResponse.dart';
import 'package:education_app/Model/SubsPlans.dart';
import 'package:education_app/Model/error_model.dart';
import 'package:education_app/Model/profile_response.dart';
import 'package:education_app/Model/student_info_response.dart';
import 'package:education_app/Model/subs_details.dart';
import 'package:education_app/Model/subs_response.dart';
import 'package:education_app/Network/sub_request.dart';
import 'package:education_app/Network/update_profile_request.dart';
import 'package:education_app/ui/home/HomeScreen.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PlansScreen extends StatefulWidget {
  final ProfileResponse profileResponse;
  PlansScreen({Key key, @required this.profileResponse}) : super(key: key);

  @override
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  final bloc = SubscriptionBloc();
  var box = Hive.box('cred');
  Razorpay _razorpay;
  bool enable;
  String subId;

  @override
  void initState() {
    enable = true;
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    bloc.getPlans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: _buildPlansPage(),
      ),
    );
  }

  void openCheckout(int amount, String subId) async {
    var options = {
      'key': 'rzp_test_tEP3lsuIxaAzIJ',
      'name': 'AKS Physiology.',
      'subscription_id': subId,
      'subscription_card_change':true,
      'description': 'Premium Subscription',
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _goBack() {
    Navigator.of(context).pop();
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) {
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
                  _validateSubscription(subId);
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

  _handlePaymentError(PaymentFailureResponse response) {
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

  _handleExternalWallet() {}

  Widget _buildPlansPage() {
    return StreamBuilder(
        stream: bloc.planStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              Map<String, dynamic> map = snapshot.data;
              if (map.containsKey('plans')) {
                SubsPlans subsPlans = map['plans'];
                return _buildPlansList(subsPlans);
              } else {
                ErrorModel errorModel = map['error'];
                return _buildErrorWidget(errorModel);
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
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

  Widget _buildPlansList(SubsPlans plans) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child:
              Lottie.asset('assets/raw/plus.json', repeat: false, width: 200),
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Select A Plan',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 16, 32),
                  child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount:
                          plans.items.isNotEmpty ? plans.items.length : 0,
                      children: List.generate(
                          plans.items.isNotEmpty ? plans.items.length : 0,
                          (index) {
                        Items _item = plans.items[index];
                        String period = 'Year';
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              if (enable) {
                                enable = false;
                                _createSubscription(_item);
                              }
                            },
                            child: Card(
                                shadowColor: Colors.black,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(32),
                                        topLeft: Radius.circular(32),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8))),
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _item.item.name,
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _item.item.description != null
                                            ? _item.item.description
                                            : "",
                                        style: TextStyle(fontSize: 18),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "₹ ${(_item.item.amount / 100).toInt().toString()}/${_item.period != null ? _item.period : period}",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      })),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(ErrorModel errorModel) {
    return Center(child: Text(errorModel.description));
  }

  void _createSubscription(Items _item) {
    String period = 'Year';
    Dialog _subsDialog = Dialog(
      child: Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _item.item.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _item.item.description != null ? _item.item.description : "",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "You will be charged ₹ ${(_item.item.amount / 100).toInt().toString()}/${_item.period != null ? _item.period : period}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child:
                          Text('Cancel', style: TextStyle(color: Colors.red)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        setState(() {
                          enable = true;
                        });
                        Navigator.of(context).pop();

                        SubsRequest _subsRequest = SubsRequest(
                          planId: _item.id,
                          totalCount: 1,
                          quantity: 1,
                          customerNotify: 0,
                        );

                        _initiateSubscription(_subsRequest, _item);
                      },
                      child: Text(
                        'Start Subscription',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (context) {
        return _subsDialog;
      },
    );
  }

  void _initiateSubscription(SubsRequest subsRequest, Items item) {
    BuildContext dialogContext;
    Dialog _loadingDialog = Dialog(
      child: Container(
        height: 90,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        )),
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          dialogContext = context;
          return _loadingDialog;
        });
    bloc.createSubscription(subsRequest);
    bloc.subsStream.listen((event) {
      Map<String, dynamic> map = event;
      if (map.containsKey('subs')) {
        Navigator.pop(dialogContext);
        SubsResponse subsResponse = map['subs'];
        subId = subsResponse.id;
        openCheckout(item.item.amount, subsResponse.id);
      } else {
        Navigator.pop(dialogContext);

        _createErrorDialog('Subcriptions not created. Try again later');
      }
    });
  }

  void _createErrorDialog(String message) {
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
              child: Text('$message',
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

  void _createSuccessDialog(String message, ProfileResponse profileResponse,
      LoginResponse loginResponse) {
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
                child: Lottie.asset('assets/raw/done.json', repeat: false),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$message',
                  style: TextStyle(color: Colors.red, fontSize: 18.0)),
            ),
            TextButton(
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

  void _validateSubscription(String subId) {
    BuildContext _dialogContext;
    Dialog _loadingDialog = Dialog(
      child: Container(
        height: 90,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        )),
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          _dialogContext = context;
          return _loadingDialog;
        });

    bloc.getSubcription(subId);
    bloc.subDStream.listen((event) {
      Map<String, dynamic> map = event;
      if (map.containsKey('subd')) {
        SubsDetails subsDetails = map['subd'];
        if (subsDetails.status == 'active') {
          String email = box.get('email');
          UpdateProfileRequest _updateRequest = UpdateProfileRequest(
              email: email,
              name: widget.profileResponse.studentInfo.name,
              contactNumber: widget.profileResponse.studentInfo.contactNumber,
              address: widget.profileResponse.studentInfo.address,
              country: widget.profileResponse.studentInfo.country,
              gender: widget.profileResponse.studentInfo.gender,
              dob: widget.profileResponse.studentInfo.dob,
              premiumUser: true,
              subscriptionId: subId);
          bloc.updateStudentInfo(_updateRequest);
          bloc.studentInfoStream.listen((event) {
            Map<String, dynamic> response = event;
            if (response.containsKey('stdInfo')) {
              StudentInfoResponse studentInfoResponse = response['stdInfo'];
              if (studentInfoResponse.statusCode == 100) {
                bloc.getProfile();
                bloc.profileStream.listen((event) {
                  ProfileResponse profileResponse = event;
                  LoginResponse loginResponse = box.get('loginResponse');
                  Navigator.pop(_dialogContext);
                  _createSuccessDialog('Subscription Activated Successfully',
                      profileResponse, loginResponse);
                });
              }
            } else {
              Navigator.pop(_dialogContext);
              _createErrorDialog(
                  'Subscription Not Created. Contact Us If any amount is debited from your account');
            }
          });
        } else {
          Navigator.pop(_dialogContext);
          _createErrorDialog(
              'Subscription Not Created. Contact Us If any amount is debited from your account');
        }
      } else {
        Navigator.pop(_dialogContext);
        _createErrorDialog(
            'Subscription Not Created. Contact Us If any amount is debited from your account');
      }
    });
  }
}
