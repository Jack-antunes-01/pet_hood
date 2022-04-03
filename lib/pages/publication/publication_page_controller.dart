import 'package:camera/camera.dart';
import 'package:get/state_manager.dart';

class PublicationPageController extends GetxController {
  final RxInt _selectedOption = RxInt(0);

  int get selectedOption => _selectedOption.value;

  set selectedOption(int index) => _selectedOption.value = index;

  final List items = ["", "Normal", "Adoção", "Desaparecido", "Encontrado"];
}
