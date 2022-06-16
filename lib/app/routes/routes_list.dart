import 'package:get/route_manager.dart';
import 'package:pet_hood/app/bindings/home_bindings.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/pages/pages.dart';

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
          page: () => const FirstRegisterForm(),
        ),
        GetPage(
          name: Routes.register2,
          page: () => const SecondRegisterForm(),
        ),
        GetPage(
          name: Routes.termsOfUse,
          page: () => const TermsOfUsePage(),
        ),
        GetPage(
          name: Routes.home,
          page: () => const HomePage(),
          binding: HomeBindings(),
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
