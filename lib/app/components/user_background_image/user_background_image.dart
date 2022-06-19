import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pet_hood/app/theme/colors.dart';

class UserBackgroundImage extends StatelessWidget {
  final String? backgroundImage;
  final bool isLoading;

  const UserBackgroundImage({
    Key? key,
    this.backgroundImage,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBackgroundImage();
  }

  Widget _buildBackgroundImage() {
    if (backgroundImage != null && backgroundImage!.isNotEmpty) {
      return Row(
        children: [
          Expanded(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(isLoading ? 0.4 : 0),
                BlendMode.darken,
              ),
              child: Image.network(
                '${dotenv.env["API_IMAGE"]}$backgroundImage',
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
