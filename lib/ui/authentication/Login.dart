import 'package:education_app/Bloc/LoginBloc.dart';
import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/Model/LoginResponse.dart';
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
Login(BuildContext context, Size size) {
  String _email;
  String _password;
  GlobalKey<FormState> _key = GlobalKey();
  Dio dio = Dio();
  // Scaffold.of(context).showBottomSheet((context) {
  //   return _loginBottomSheet(size);
  // });

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
        final bloc = LoginBloc();
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
                              child: Container(
                              child: CircularProgressIndicator(),
                            ))
                          : RoundedButton(
                              text: "LOGIN",
                              press: () {
                                if (_key.currentState.validate()) {
                                  _key.currentState.save();
                                  showLoading = true;

                                  bloc.login(_email, _password, dio);
                                }
                              },
                            ),
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
                _buildResult(bloc)
              ]),
            ),
          ),
        );
      });
}

Widget _buildResult(
  LoginBloc bloc,
) {
  LoginResponse loginResponse;
  return StreamBuilder(
    stream: bloc.loginStream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.active) {
        if (snapshot.hasError) {
          return _showMessage(
              snapshot.error.toString(), 'Error', context, loginResponse);
        } else {
          showLoading = false;
          loginResponse = snapshot.data;
          if (loginResponse == null) {
            return Container(
              child: CircularProgressIndicator(),
            );
          } else {
            if (loginResponse.message == 'Successful') {
              return _showMessage(
                  loginResponse.message, '', context, loginResponse);
            } else if (loginResponse.message ==
                'Email is sent for Verification') {
              return _showMessage(
                  loginResponse.message, '', context, loginResponse);
            } else {
              return _showMessage(
                  loginResponse.message, '', context, loginResponse);
            }
          }
        }
      } else {
        return Container();
      }
    },
  );
}

Widget _showMessage(String message, String title, BuildContext context,
    LoginResponse loginResponse) {
  return AlertDialog(
    titlePadding: EdgeInsets.all(4.0),
    content: Text('$message'),
    actions: [
      TextButton(
          onPressed: () {
            message == 'Successful'
                ? SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                      return Home(loginResponse: loginResponse);
                    }), (route) => false);
                  })
                : Navigator.of(context).pop();
          },
          child: Text('Ok'))
    ],
  );
}
