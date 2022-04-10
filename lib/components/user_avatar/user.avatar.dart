import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double size;
  final String avatar;

  const UserAvatar({
    Key? key,
    this.size = 80,
    this.avatar = "assets/images/user_avatar.jpg",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          width: 3,
          color: Colors.white,
        ),
        image: DecorationImage(
          image: AssetImage(avatar),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
  }
}
