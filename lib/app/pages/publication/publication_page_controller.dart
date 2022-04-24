import 'package:get/state_manager.dart';

class PublicationPageController extends GetxController {
  PublicationPageController._privateConstructor();
  static final PublicationPageController _instance =
      PublicationPageController._privateConstructor();
  factory PublicationPageController() {
    return _instance;
  }

  final RxInt _selectedOption = RxInt(0);
  int get selectedOption => _selectedOption.value;
  set selectedOption(int index) => _selectedOption.value = index;

  final List items = ["", "Meu pet", "Adoção", "Desaparecido", "Encontrado"];
}
