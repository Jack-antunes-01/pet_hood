import 'package:get/state_manager.dart';

class HomePageController extends GetxController {
  /// Singleton
  HomePageController._privateConstructor();
  static final HomePageController _instance =
      HomePageController._privateConstructor();
  factory HomePageController() {
    return _instance;
  }

  final RxBool _isBottomTabVisible = RxBool(true);
  bool get isBottomTabVisible => _isBottomTabVisible.value;
  set isBottomTabVisible(bool isBottomTabVisible) =>
      _isBottomTabVisible.value = isBottomTabVisible;

  final RxInt _selectedIndex = RxInt(0);
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int index) => _selectedIndex.value = index;

  void clear() {
    selectedIndex = 0;
    isBottomTabVisible = true;
  }
}
