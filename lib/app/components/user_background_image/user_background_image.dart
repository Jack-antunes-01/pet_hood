import 'package:flutter/material.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/constants/app_constants.dart';
import 'package:pet_hood/app/theme/colors.dart';

class UserBackgroundImage extends StatelessWidget {
  final String? backgroundImage;

  const UserBackgroundImage({
    Key? key,
    this.backgroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        image: backgroundImage != null
            ? DecorationImage(
                image: AssetImage(backgroundImage!),
                fit: BoxFit.cover,
              )
            : null,
        color: backgroundImage != null ? null : grey200,
      ),
      child: backgroundImage != null
          ? null
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CustomText(
                  text: appTitle,
                  color: primary,
                  fontFamily: "Grand Hotel",
                  fontSize: 50,
                ),
              ],
            ),
    );
  }
}
