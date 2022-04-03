import 'package:get/state_manager.dart';

class LoginPageController extends GetxController {
  final RxBool _hidePassword = RxBool(true);

  bool get hidePassword => _hidePassword.value;

  set hidePassword(bool value) => _hidePassword.value = value;
}
