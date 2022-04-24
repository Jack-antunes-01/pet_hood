import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  /// Singleton
  RegisterController._privateConstructor();

  static final RegisterController _instance =
      RegisterController._privateConstructor();

  factory RegisterController() {
    return _instance;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool _hidePassword = RxBool(true);
  bool get hidePassword => _hidePassword.value;
  set hidePassword(bool value) => _hidePassword.value = value;

  final RxBool _hideConfirmPassword = RxBool(true);
  bool get hideConfirmPassword => _hideConfirmPassword.value;
  set hideConfirmPassword(bool value) => _hideConfirmPassword.value = value;

  final RxBool _loading = RxBool(false);
  bool get loading => _loading.value;
  set loading(bool isLoading) => _loading.value = isLoading;
}
