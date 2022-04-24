import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfilePageController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  final RxBool _loading = RxBool(false);
  bool get loading => _loading.value;
  set loading(bool isLoading) => _loading.value = isLoading;
}
