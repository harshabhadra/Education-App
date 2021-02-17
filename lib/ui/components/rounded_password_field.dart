import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({Key key, this.onChanged, this.text})
      : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        initialValue: widget.text,
        obscureText: _obscureText,
        onChanged: widget.onChanged,
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
            icon: _obscureText
                ? Icon(
                    Icons.visibility,
                    color: kPrimaryColor,
                  )
                : Icon(
                    Icons.visibility_off,
                    color: kPrimaryColor,
                  ),
            onPressed: () {
              _toggle();
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
