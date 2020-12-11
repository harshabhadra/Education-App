import 'package:education_app/Bloc/SignUpBloc.dart';
import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/Model/SignUpResponse.dart';
import 'package:education_app/ui/authentication/StudentInfo.dart';
import 'package:education_app/ui/components/already_have_an_account_acheck.dart';
import 'package:education_app/ui/components/or_divider.dart';
import 'package:education_app/ui/components/rounded_button.dart';
import 'package:education_app/ui/components/rounded_input_field.dart';
import 'package:education_app/ui/components/rounded_password_field.dart';
import 'package:education_app/ui/components/social_icon.dart';
import 'package:education_app/ui/welcome/welcomepage.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/scheduler.dart';

SignUpUi(BuildContext context, Size size) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60),
        ),
      ),
      builder: (context) {
        return SignUpBottomSheet(
          size: size,
        );
      });
}

class SignUpBottomSheet extends StatefulWidget {
  final Size size;

  const SignUpBottomSheet({Key key, this.size}) : super(key: key);

  @override
  _SignUpBottomSheetState createState() => _SignUpBottomSheetState();
}

class _SignUpBottomSheetState extends State<SignUpBottomSheet> {
  String _email;
  String _password;
  GlobalKey<FormState> _key = GlobalKey();
  Dio dio = Dio();
  Size size;
  bool showLoading;
  bool emailExist;
  bool isWeekPass;
  bool isRegistered;

  @override
  void initState() {
    size = widget.size;
    showLoading = false;
    emailExist = false;
    isWeekPass = false;
    isRegistered = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = SignUpBloc();
    return BlocProvider<SignUpBloc>(
        bloc: bloc,
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Stack(children: [
              Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Image.asset(
                        "assets/images/login.jpg",
                        height: size.width * 0.45,
                      ),
                    ),
                    RoundedInputField(
                      hintText: "Your Email",
                      onChanged: (value) {
                        _email = value;
                        print(value);
                      },
                    ),
                    RoundedPasswordField(
                      onChanged: (value) {
                        _password = value;
                        print(value);
                      },
                    ),
                    showLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : RoundedButton(
                            text: "SIGN UP",
                            press: () {
                              if (_key.currentState.validate()) {
                                _key.currentState.save();
                                bloc.signUp(_email, _password, dio);
                                _showLoader(bloc);
                              }
                            },
                          ),

                    emailExist
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'Account already exists by this Email Id',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16)),
                            ),
                          )
                        : Container(),
                    isWeekPass
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'Weak Password, Use More than 5 Chracters',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16)),
                            ),
                          )
                        : Container(),
                    SizedBox(height: size.height * 0.03),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                      child: AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),

                    // OrDivider(),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       SocalIcon(
                    //         iconSrc: "assets/images/facebook.svg",
                    //         press: () {},
                    //       ),
                    //       SocalIcon(
                    //         iconSrc: "assets/images/google-plus.svg",
                    //         press: () {},
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }

  void _showLoader(SignUpBloc bloc) {
    setState(() {
      showLoading = true;
      emailExist = false;
      isWeekPass = false;
    });

    bloc.signUpStream.listen((event) {
      setState(() {
        showLoading = false;
        SignUpResponse response = event;
        print("Sign up response: ${response.message}");
        if (response.statusCode == 100) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return WelcomePage();
            }), (route) => false);
          });
        } else if (response.statusCode == 200) {
          emailExist = true;
        } else if (response.statusCode == 201) {
          isWeekPass = true;
        }
      });
    });
  }
}
