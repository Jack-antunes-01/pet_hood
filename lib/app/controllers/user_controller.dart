import 'dart:io';

import 'package:get/get.dart';

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
}
