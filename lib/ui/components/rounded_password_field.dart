import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _showPassword = false;
    return TextFieldContainer(
      child: TextFormField(
        obscureText: !_showPassword,
        onChanged: onChanged,
        validator: (value) {
          if (value.isEmpty) {
            return 'This Field Cannot be Empty';
          }
          return null;
        },
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.visibility,
              color: kPrimaryColor,
            ),
            onPressed: () {
             
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
