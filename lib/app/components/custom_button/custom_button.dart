import 'package:flutter/material.dart';
import 'package:pet_hood/app/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPress;

  const CustomButton({
    Key? key,
    required this.child,
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
            child: child,
          ),
        ),
      ),
    );
  }
}
