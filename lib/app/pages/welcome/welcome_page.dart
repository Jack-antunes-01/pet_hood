import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:pet_hood/app/components/custom_button/custom_button.dart';
import 'package:pet_hood/app/constants/constants.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/theme/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.bottom;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
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
                text: "Continuar",
                onPress: () => Get.toNamed(Routes.login),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
