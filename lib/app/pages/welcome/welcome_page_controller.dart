import 'package:get/get.dart';

class WelcomePageController extends GetxController {
  final RxBool _loading = RxBool(false);
  bool get loading => _loading.value;
  set loading(bool isLoading) => _loading.value = isLoading;
}
