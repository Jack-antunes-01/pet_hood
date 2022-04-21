import 'package:flutter/material.dart';
import 'package:pet_hood/app/theme/colors.dart';

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
  final bool labelActive;
  final Icon? prefixIcon;

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
    this.labelActive = true,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null || suffixIconReverse != null
            ? GestureDetector(
                onTap: onIconPress,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: obscureText ? suffixIcon : suffixIconReverse,
                ),
              )
            : null,
        contentPadding: const EdgeInsets.all(15),
        prefixIcon: prefixIcon,
        fillColor: backgroundColor,
        filled: true,
        labelText: labelActive ? placeholderText : null,
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
