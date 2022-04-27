import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_hood/app/theme/colors.dart';

class CustomInput extends StatelessWidget {
  final String placeholderText;

  final Color backgroundColor;
  final Color placeholderColor;
  final double fontSize;
  final bool obscureText;
  final TextInputType keyboardType;
  final Icon? suffixIcon;
  final Icon? suffixIconReverse;
  final VoidCallback? onIconPress;
  final TextEditingController? controller;
  final bool readOnly;
  final bool labelActive;
  final Icon? prefixIcon;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final void Function(String?)? onFieldSubmitted;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final void Function(String?)? onChanged;

  const CustomInput({
    Key? key,
    required this.placeholderText,
    this.inputFormatters,
    this.validator,
    this.backgroundColor = inputColor,
    this.placeholderColor = placeholder,
    this.fontSize = 16,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.suffixIconReverse,
    this.onIconPress,
    this.controller,
    this.readOnly = false,
    this.labelActive = true,
    this.prefixIcon,
    this.autofocus = false,
    this.textInputAction,
    this.onFieldSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatters,
      autocorrect: false,
      autofocus: autofocus,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      textCapitalization: textCapitalization,
      maxLength: maxLength,
      onChanged: onChanged,
      decoration: InputDecoration(
        counterText: "",
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
