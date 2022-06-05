import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pet_hood/app/theme/colors.dart';

class UserAvatar extends StatelessWidget {
  final double size;
  final File? avatarFile;
  final String? avatar;
  final bool useBorder;
  final bool isLoading;

  const UserAvatar({
    Key? key,
    this.size = 80,
    this.avatarFile,
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
    if (avatarFile != null && avatarFile?.path != "") {
      return ClipOval(
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(isLoading ? 0.4 : 0),
            BlendMode.darken,
          ),
          child: Image.file(
            avatarFile!,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (avatar != null && avatar!.isNotEmpty) {
      return ClipOval(
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(isLoading ? 0.4 : 0),
            BlendMode.darken,
          ),
          child: Image.network(
            'http://192.168.1.8:3333/uploads/$avatar',
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
