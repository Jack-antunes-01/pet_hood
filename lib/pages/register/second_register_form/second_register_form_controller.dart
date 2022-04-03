import 'package:get/state_manager.dart';

class SecondRegisterFormController extends GetxController {
  final RxBool _hidePassword = RxBool(true);

  bool get hidePassword => _hidePassword.value;

  set hidePassword(bool value) => _hidePassword.value = value;

  final RxBool _hideConfirmPassword = RxBool(true);

  bool get hideConfirmPassword => _hideConfirmPassword.value;

  set hideConfirmPassword(bool value) => _hideConfirmPassword.value = value;
}
