import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_hood/app/theme/colors.dart';

class UserBackgroundImage extends StatelessWidget {
  // final String? backgroundImage;
  final File? backgroundImage;

  const UserBackgroundImage({
    Key? key,
    this.backgroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return backgroundImage?.path != ""
        ? Row(
            children: [
              Expanded(
                child: Image.file(
                  backgroundImage!,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : Container(
            height: 120,
            decoration: const BoxDecoration(
              color: grey200,
            ),
          );
  }
}
