import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/widget/textField_deco.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {Key? key,
      required this.controller,
      required this.textLabel,
      required this.obscureText})
      : super(key: key);

  final TextEditingController controller;
  final String textLabel;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        onChanged: ((value) {}),
        obscureText: obscureText,
        textAlign: TextAlign.center,
        decoration: TextFieldDecoration(textLabel));
  }
}
