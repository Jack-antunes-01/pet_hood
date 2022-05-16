import 'package:get/get.dart';
import 'package:pet_hood/app/controllers/adoption_controller.dart';
import 'package:pet_hood/app/controllers/pet_details_controller.dart';
import 'package:pet_hood/app/pages/feed/feed_controller.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PublicationPageController());
    Get.lazyPut(() => AdoptionController());
    Get.lazyPut(() => FeedController());
    Get.lazyPut(() => PetDetailsController());
  }
}
