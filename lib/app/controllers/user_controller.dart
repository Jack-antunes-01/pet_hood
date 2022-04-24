import 'dart:io';

import 'package:get/get.dart';
import 'package:pet_hood/core/entities/user_entity.dart';

class UserController extends GetxController {
  /// Singleton
  UserController._privateConstructor();

  static final UserController _instance = UserController._privateConstructor();

  factory UserController() {
    return _instance;
  }

  /// Profile Image
  final Rx<File> _profileImage = Rx<File>(File(''));
  File get profileImage => _profileImage.value;
  set profileImage(File image) => _profileImage.value = image;

  /// Background Image
  final Rx<File> _backgroundImage = Rx<File>(File(''));
  File get backgroundImage => _backgroundImage.value;
  set backgroundImage(File image) => _backgroundImage.value = image;

  final Rx<UserEntity> _userEntity = Rx<UserEntity>(
    UserEntity(
      id: "",
      email: "",
      name: "",
      userName: "",
      phoneNumber: "",
      profileImage: "",
      backgroundImage: "",
      birthDate: "",
      bio: "",
    ),
  );
  UserEntity get userEntity => _userEntity.value;
  set userEntity(UserEntity entity) => _userEntity.value = entity;

  String password = "";
}
