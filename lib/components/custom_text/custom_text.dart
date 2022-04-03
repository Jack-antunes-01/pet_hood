import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final String? fontFamily;

  const CustomText({
    Key? key,
    required this.text,
    required this.color,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 16,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }
}
