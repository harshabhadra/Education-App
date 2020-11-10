import 'package:education_app/Bloc/SignUpBloc.dart';
import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/Model/SignUpResponse.dart';
import 'package:education_app/ui/components/already_have_an_account_acheck.dart';
import 'package:education_app/ui/components/or_divider.dart';
import 'package:education_app/ui/components/rounded_button.dart';
import 'package:education_app/ui/components/rounded_input_field.dart';
import 'package:education_app/ui/components/rounded_password_field.dart';
import 'package:education_app/ui/components/social_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

SignUpUi(BuildContext context, Size size) {
  String _email;
  String _password;
  GlobalKey<FormState> _key = GlobalKey();
  Dio dio = Dio();

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
                        RoundedButton(
                          text: "SIGN UP",
                          press: () {
                            if (_key.currentState.validate()) {
                              _key.currentState.save();
                              bloc.signUp(_email, _password, dio);
                            }
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        AlreadyHaveAnAccountCheck(
                          login: false,
                          press: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        OrDivider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SocalIcon(
                                iconSrc: "assets/images/facebook.svg",
                                press: () {},
                              ),
                              SocalIcon(
                                iconSrc: "assets/images/google-plus.svg",
                                press: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildResult(bloc),
                  ),
                ]),
              ),
            ));
      });
}

Widget _buildResult(
  SignUpBloc bloc,
) {
  SignUpResponse signUpResponse;
  return StreamBuilder(
    stream: bloc.signUpStream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.active) {
        if (snapshot.hasError) {
          return _showMessage(snapshot.error.toString(), 'Error', context);
        } else {
          signUpResponse = snapshot.data;
          if (signUpResponse == null) {
            return Container(
              child: CircularProgressIndicator(),
            );
          } else {
            if (signUpResponse.message == 'Successful') {
              return _showMessage(
                  signUpResponse.message, 'Account Created', context);
            } else {
              return _showMessage(signUpResponse.message, '', context);
            }
          }
        }
      } else {
        return Container();
      }
    },
  );
}

Widget _showMessage(String message, String title, BuildContext context) {
  return AlertDialog(
    titlePadding: EdgeInsets.all(4.0),
    content: Text('$title $message'),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Ok'))
    ],
  );
}
