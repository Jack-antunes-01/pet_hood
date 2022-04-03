import 'package:get/state_manager.dart';

class HomePageController extends GetxController {
  final RxInt _selectedIndex = RxInt(0);
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int index) => _selectedIndex.value = index;
}
