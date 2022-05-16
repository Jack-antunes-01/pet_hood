import 'package:get/get.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/database/api_adapter.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => ApiAdapter(), fenix: true);
  }
}
