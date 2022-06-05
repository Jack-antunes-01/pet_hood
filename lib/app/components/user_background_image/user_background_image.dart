import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_hood/app/theme/colors.dart';

class UserBackgroundImage extends StatelessWidget {
  final String? backgroundImage;
  final File? backgroundImageFile;
  final bool isLoading;
// Image.network(
//             'http://192.168.1.8:3333/uploads/$avatar',
//             fit: BoxFit.cover,
//           ),
  const UserBackgroundImage({
    Key? key,
    this.backgroundImage,
    this.backgroundImageFile,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBackgroundImage();
  }

  Widget _buildBackgroundImage() {
    if (backgroundImageFile?.path != "") {
      return Row(
        children: [
          Expanded(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(isLoading ? 0.4 : 0),
                BlendMode.darken,
              ),
              child: Image.file(
                backgroundImageFile!,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
    } else if (backgroundImage != null) {
      return Row(
        children: [
          Expanded(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(isLoading ? 0.4 : 0),
                BlendMode.darken,
              ),
              child: Image.network(
                'http://192.168.1.8:3333/uploads/$backgroundImage',
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
        height: 120,
        decoration: const BoxDecoration(
          color: grey200,
        ),
      );
    }
  }
}
