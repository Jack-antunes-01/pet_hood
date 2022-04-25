import 'package:get/get.dart';
import 'package:pet_hood/app/controllers/adoption_controller.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PublicationPageController());
    Get.lazyPut(() => AdoptionController());
  }
}
