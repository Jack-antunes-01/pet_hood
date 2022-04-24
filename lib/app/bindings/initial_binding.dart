import 'package:get/get.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController(), fenix: true);
  }
}
