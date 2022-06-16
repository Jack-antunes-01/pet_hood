import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/constants/constants.dart';
import 'package:pet_hood/app/controllers/api_controller.dart';
import 'package:pet_hood/app/pages/welcome/welcome_page_controller.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final WelcomePageController _welcomePageController =
      Get.put(WelcomePageController());

  @override
  void initState() {
    super.initState();
    validateToken();
  }

  validateToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.get("email");
    var password = prefs.get("password");
    if (email != null && email != '' && password != null && password != '') {
      _welcomePageController.loading = true;
      await Future.delayed(const Duration(seconds: 1));
      try {
        await ApiController().loginAttempt(email as String, password as String);
      } catch (e) {
        Get.snackbar(
          "Sessão expirada",
          "Efetue login novamente.",
          backgroundColor: primary,
          colorText: base,
          duration: const Duration(seconds: 2),
        );
      }

      await Future.delayed(const Duration(milliseconds: 500));
      _welcomePageController.loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.bottom;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Obx(
        () => SizedBox(
          width: MediaQuery.of(context).size.width,
          child: _welcomePageController.loading
              ? _buildLoading()
              : Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/app_logo.svg",
                            color: primary,
                          ),
                          const Text(
                            appTitle,
                            style: TextStyle(
                              color: primary,
                              fontSize: 64,
                              fontFamily: "Grand Hotel",
                            ),
                          ),
                          const Text(
                            "A rede social voltada para pets",
                            style: TextStyle(
                              color: primary,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: height * 0.2),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: safePadding + height * 0.1,
                      right: 32,
                      left: 32,
                      child: CustomButton(
                        child: const CustomText(
                          text: "Continuar",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: base,
                        ),
                        onPress: () => Get.toNamed(Routes.login),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          color: primary,
        ),
      ),
    );
  }
}
