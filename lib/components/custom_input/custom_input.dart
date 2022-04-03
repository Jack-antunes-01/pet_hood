import 'package:flutter/material.dart';
import 'package:pet_hood/theme/colors.dart';

class CustomInput extends StatelessWidget {
  final String placeholderText;

  final Color backgroundColor;
  final Color placeholderColor;
  final double fontSize;
  final bool obscureText;
  final TextInputType textInputType;
  final Icon? suffixIcon;
  final Icon? suffixIconReverse;
  final VoidCallback? onIconPress;
  final TextEditingController? controller;
  final bool readOnly;

  const CustomInput({
    Key? key,
    required this.placeholderText,
    this.backgroundColor = inputColor,
    this.placeholderColor = placeholder,
    this.fontSize = 16,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.suffixIcon,
    this.suffixIconReverse,
    this.onIconPress,
    this.controller,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: onIconPress,
          child: SizedBox(
            width: 50,
            height: 50,
            child: obscureText ? suffixIcon : suffixIconReverse,
          ),
        ),
        contentPadding: const EdgeInsets.all(15),
        fillColor: backgroundColor,
        filled: true,
        labelText: placeholderText,
        labelStyle: TextStyle(
          fontSize: fontSize,
          color: placeholderColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        hintText: placeholderText,
        hintStyle: TextStyle(
          fontSize: fontSize,
          color: placeholderColor,
        ),
      ),
    );
  }
}
