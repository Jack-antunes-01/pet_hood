import 'package:get/route_manager.dart';
import 'package:pet_hood/pages/about_us/about_us.dart';
import 'package:pet_hood/pages/adoption/category_list/category_list.dart';
import 'package:pet_hood/pages/adoption/pet_details/pet_details.dart';
import 'package:pet_hood/pages/chat/chat_page.dart';
import 'package:pet_hood/pages/chat/chat_people_page.dart';
import 'package:pet_hood/pages/pages.dart';
import 'package:pet_hood/pages/profile/edit_profile_page.dart';
import 'package:pet_hood/pages/ranking/ranking_page.dart';
import 'package:pet_hood/pages/stakeholders/stakeholders_page.dart';

import '../pages/profile/external_profile_page.dart';

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
        GetPage(name: editProfile, page: () => const EditProfilePage()),
        GetPage(name: aboutUs, page: () => const AboutUsPage()),
        GetPage(name: stakeholders, page: () => const StakeholdersPage()),
        GetPage(name: ranking, page: () => const RankingPage()),
        GetPage(name: externalProfile, page: () => const ExternalProfilePage()),
        GetPage(name: chat, page: () => const ChatPage()),
        GetPage(name: chatPeople, page: () => const ChatPeoplePage()),
      ];

  static String get welcome => "/welcome";
  static String get login => "/login";
  static String get register => "/register";
  static String get register2 => "/register_2";
  static String get termsOfUse => "/terms_of_use";
  static String get home => "/";
  static String get categoryList => "/category_list";
  static String get petDetails => "/pet_details";
  static String get editProfile => "/edit_profile";
  static String get aboutUs => "/about_us";
  static String get stakeholders => "/stakeholders";
  static String get ranking => "/ranking";
  static String get externalProfile => "/external_profile";
  static String get chat => "/chat";
  static String get chatPeople => "/chat_people";
}
