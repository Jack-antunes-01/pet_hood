import 'package:get/route_manager.dart';
import 'package:pet_hood/pages/adoption/category_list/category_list.dart';
import 'package:pet_hood/pages/adoption/pet_details/pet_details.dart';
import 'package:pet_hood/pages/pages.dart';

abstract class Routes {
  static List<GetPage> get routeList => [
        GetPage(name: welcome, page: () => const WelcomePage()),
        GetPage(name: login, page: () => LoginPage()),
        GetPage(name: register, page: () => FirstRegisterForm()),
        GetPage(name: register2, page: () => SecondRegisterForm()),
        GetPage(name: termsOfUse, page: () => const TermsOfUsePage()),
        GetPage(name: home, page: () => HomePage()),
        GetPage(name: categoryList, page: () => const CategoryList()),
        GetPage(name: petDetails, page: () => PetDetails()),
      ];

  static String get welcome => "/welcome";
  static String get login => "/login";
  static String get register => "/register";
  static String get register2 => "/register_2";
  static String get termsOfUse => "/terms_of_use";
  static String get home => "/";
  static String get categoryList => "/category_list";
  static String get petDetails => "/pet_details";
}
