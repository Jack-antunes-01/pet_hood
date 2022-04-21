import 'package:get/route_manager.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/pages/about_us/about_us.dart';
import 'package:pet_hood/app/pages/adoption/category_list/category_list.dart';
import 'package:pet_hood/app/pages/adoption/pet_details/pet_details.dart';
import 'package:pet_hood/app/pages/chat/chat_page.dart';
import 'package:pet_hood/app/pages/chat/chat_people_page.dart';
import 'package:pet_hood/app/pages/pages.dart';
import 'package:pet_hood/app/pages/profile/edit_profile_page.dart';
import 'package:pet_hood/app/pages/profile/external_profile_page.dart';
import 'package:pet_hood/app/pages/ranking/ranking_page.dart';
import 'package:pet_hood/app/pages/stakeholders/stakeholders_page.dart';

abstract class RoutesList {
  static List<GetPage> get routes => [
        GetPage(
          name: Routes.welcome,
          page: () => const WelcomePage(),
        ),
        GetPage(
          name: Routes.login,
          page: () => LoginPage(),
        ),
        GetPage(
          name: Routes.register,
          page: () => FirstRegisterForm(),
        ),
        GetPage(
          name: Routes.register2,
          page: () => SecondRegisterForm(),
        ),
        GetPage(
          name: Routes.termsOfUse,
          page: () => const TermsOfUsePage(),
        ),
        GetPage(
          name: Routes.home,
          page: () => HomePage(),
        ),
        GetPage(
          name: Routes.categoryList,
          page: () => const CategoryList(),
        ),
        GetPage(
          name: Routes.petDetails,
          page: () => PetDetails(),
        ),
        GetPage(
          name: Routes.editProfile,
          page: () => const EditProfilePage(),
        ),
        GetPage(
          name: Routes.aboutUs,
          page: () => const AboutUsPage(),
        ),
        GetPage(
          name: Routes.stakeholders,
          page: () => const StakeholdersPage(),
        ),
        GetPage(
          name: Routes.ranking,
          page: () => const RankingPage(),
        ),
        GetPage(
          name: Routes.externalProfile,
          page: () => const ExternalProfilePage(),
        ),
        GetPage(
          name: Routes.chat,
          page: () => const ChatPage(),
        ),
        GetPage(
          name: Routes.chatPeople,
          page: () => const ChatPeoplePage(),
        ),
      ];
}
