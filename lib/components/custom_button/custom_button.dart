import 'package:flutter/material.dart';
import 'package:pet_hood/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: primary,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: onPress,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: base,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
