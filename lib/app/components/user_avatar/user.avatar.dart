import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pet_hood/app/theme/colors.dart';

class UserAvatar extends StatelessWidget {
  final double size;
  final String? avatar;
  final bool useBorder;
  final bool isLoading;

  const UserAvatar({
    Key? key,
    this.size = 80,
    this.avatar,
    this.useBorder = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: base,
        shape: BoxShape.circle,
        border: useBorder
            ? Border.all(
                width: 2,
                color: base,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: _buildAvatar(),
    );
  }

  Widget _buildAvatar() {
    if (avatar != null && avatar!.isNotEmpty) {
      return ClipOval(
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(isLoading ? 0.4 : 0),
            BlendMode.darken,
          ),
          child: Image.network(
            '${dotenv.env["API_IMAGE"]}$avatar',
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Icon(
          Icons.pets_rounded,
          size: size - 15,
          color: grey600,
        ),
      );
    }
  }
}
