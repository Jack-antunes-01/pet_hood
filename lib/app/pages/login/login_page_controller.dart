import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  final TextEditingController emailController =
      TextEditingController(text: "mavi@teste.com");
  final TextEditingController passwordController =
      TextEditingController(text: "Am0retern0!");

  final RxBool _hidePassword = RxBool(true);
  bool get hidePassword => _hidePassword.value;
  set hidePassword(bool value) => _hidePassword.value = value;

  final RxBool _loading = RxBool(false);
  bool get loading => _loading.value;
  set loading(bool isLoading) => _loading.value = isLoading;
}
