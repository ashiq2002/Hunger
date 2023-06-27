import 'package:flutter/material.dart';
import 'package:hunger/provider/text_field_provider.dart';
import 'package:provider/provider.dart';

enum TextFiledType{username, email, password, confirmPassword}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool isPassword;
  final TextFiledType type;
  final void Function(String)? onChanged;
  final String? errorMessage;

  const MyTextField({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.isPassword,
    required this.controller,
    required this.type, this.onChanged, this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<TextFieldProvider>(builder: (context, value, child) {
      return TextFormField(
        controller: controller,
        obscureText: !isPassword ? false : !value.isVisible,
        decoration: InputDecoration(
            filled: true,
            errorText: errorMessage,
            fillColor: Colors.grey.shade300,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade50)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade100)),
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: !isPassword
                ? suffixIcon
                : GestureDetector(
                    onTap: () {
                      value.setIsVisible();
                    },
                    child: Icon(value.isVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                  ),
            hintStyle: TextStyle(color: Colors.grey.shade400)),

        onChanged: onChanged
      );
    });
  }
}
