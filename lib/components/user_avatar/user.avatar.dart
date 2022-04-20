import 'package:flutter/material.dart';
import 'package:pet_hood/theme/colors.dart';

class UserAvatar extends StatelessWidget {
  final double size;
  final String avatar;
  final bool useBorder;

  const UserAvatar({
    Key? key,
    this.size = 80,
    this.avatar = "assets/images/user_avatar.jpg",
    this.useBorder = true,
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
        image: DecorationImage(
          image: AssetImage(avatar),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
  }
}
