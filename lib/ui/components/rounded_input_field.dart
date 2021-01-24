import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String text;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.text,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        initialValue: text,
        onChanged: onChanged,
        validator: (value) {
          if (value.isEmpty) {
            return 'This Field Cannot be Empty';
          }
          return null;
        },
        cursorColor: kPrimaryColor,
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
