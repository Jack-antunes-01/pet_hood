import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pet_hood/app/theme/colors.dart';

class UserAvatar extends StatelessWidget {
  final double size;
  final File? avatar;
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
      child: avatar?.path != ""
          ? ClipOval(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(isLoading ? 0.4 : 0),
                  BlendMode.darken,
                ),
                child: Image.file(
                  avatar!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Icon(
                Icons.pets_rounded,
                size: size - 15,
                color: grey600,
              ),
            ),
    );
  }
}
