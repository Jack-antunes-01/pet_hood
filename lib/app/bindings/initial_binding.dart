import 'package:get/get.dart';
import 'package:pet_hood/app/controllers/controllers.dart';
import 'package:pet_hood/app/controllers/external_profile_controller.dart';
import 'package:pet_hood/app/pages/feed/feed_controller.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/database/api_adapter.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => ApiAdapter(), fenix: true);
    Get.lazyPut(() => PublicationPageController(), fenix: true);
    Get.lazyPut(() => AdoptionController(), fenix: true);
    Get.lazyPut(() => FeedController(), fenix: true);
    Get.lazyPut(() => PetDetailsController(), fenix: true);
    Get.lazyPut(() => ExternalProfileController(), fenix: true);
  }
}
