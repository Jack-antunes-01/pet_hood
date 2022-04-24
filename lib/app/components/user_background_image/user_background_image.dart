import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_hood/app/theme/colors.dart';

class UserBackgroundImage extends StatelessWidget {
  // final String? backgroundImage;
  final File? backgroundImage;
  final bool isLoading;

  const UserBackgroundImage({
    Key? key,
    this.backgroundImage,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return backgroundImage?.path != ""
        ? Row(
            children: [
              Expanded(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(isLoading ? 0.4 : 0),
                    BlendMode.darken,
                  ),
                  child: Image.file(
                    backgroundImage!,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
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
