import 'package:education_app/Bloc/LoginBloc.dart';
import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/Model/LoginResponse.dart';
import 'package:education_app/ui/authentication/StudentInfo.dart';
import 'package:education_app/ui/components/already_have_an_account_acheck.dart';
import 'package:education_app/ui/components/rounded_button.dart';
import 'package:education_app/ui/components/rounded_input_field.dart';
import 'package:education_app/ui/components/rounded_password_field.dart';
import 'package:education_app/ui/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dio/dio.dart';

bool showLoading = false;
loginUi(BuildContext context, Size size, String email, String password) {
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
        return loginBottomSheet(
          size: size,
          email: email,
          password: password,
        );
      });
}

class loginBottomSheet extends StatefulWidget {
  final Size size;
  final String email, password;

  const loginBottomSheet({Key key, this.size, this.email, this.password})
      : super(key: key);

  @override
  _loginBottomSheetState createState() => _loginBottomSheetState();
}

class _loginBottomSheetState extends State<loginBottomSheet> {
  String _email;
  String _password;
  GlobalKey<FormState> _key = GlobalKey();
  Dio dio = Dio();
  Size size;
  bool showNoEmail;
  bool invalidCred;
  final bloc = LoginBloc();

  @override
  void initState() {
    size = widget.size;
    showLoading = false;
    showNoEmail = false;
    invalidCred = false;
    _email = widget.email;
    _password = widget.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Stack(children: [
            Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: SvgPicture.asset(
                      "assets/images/signup.svg",
                      height: size.height * 0.35,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RoundedInputField(
                    text: widget.email,
                    hintText: "Your Email",
                    onChanged: (value) {
                      _email = value;
                      print(value);
                    },
                    
                  ),
                  RoundedPasswordField(
                    text: widget.password,
                    onChanged: (value) {
                      _password = value;
                      print(value);
                    },
                  ),
                  showLoading
                      ? Center(
                          child: Container(
                          child: CircularProgressIndicator(),
                        ))
                      : RoundedButton(
                          text: "LOGIN",
                          press: () {
                            if (_key.currentState.validate()) {
                              _key.currentState.save();
                              showWidget(bloc);
                              bloc.login(_email, _password);
                            }
                          },
                        ),
                  showNoEmail
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Email is sent for verification',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                        )
                      : Container(),
                  invalidCred
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Invalid Credential',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    margin: EdgeInsets.only(bottom: 32.0),
                    child: AlreadyHaveAnAccountCheck(
                      press: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
            // _buildResult(bloc)
          ]),
        ),
      ),
    );
  }

  showWidget(LoginBloc bloc) {
    setState(() {
      showLoading = true;
      showNoEmail = false;
      invalidCred = false;
      bloc.loginStream.listen((event) {
        setState(() {
          showLoading = false;
          LoginResponse loginResponse = event;
          print('Login Response in ui : ${loginResponse.message}');
          if (loginResponse.statusCode == 100) {
            if (loginResponse.detailPresent) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return Home(loginResponse: loginResponse);
                }), (route) => false);
              });
            } else {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return StudentInfoUi(
                  email: _email,
                  password: _password,
                );
              }));
            }
          } else if (loginResponse.statusCode == 200) {
            showNoEmail = true;
          } else {
            invalidCred = true;
          }
        });
      });
    });
  }
}
