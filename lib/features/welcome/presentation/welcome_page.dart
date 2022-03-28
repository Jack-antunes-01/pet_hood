import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:pet_hood/constants/app_constants.dart';
import 'package:pet_hood/theme/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appBody(),
    );
  }

  Widget appBody() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  "assets/images/app_logo.svg",
                  color: primary,
                ),
                const Text(
                  appTitle,
                  style: TextStyle(
                    fontFamily: "Grand Hotel",
                    fontSize: 64,
                    color: primary,
                  ),
                ),
                const Text(
                  appSlogan,
                  style: TextStyle(
                    fontSize: 16,
                    color: primary,
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 80,
          right: 0,
          left: 0,
          child: Container(
            margin: const EdgeInsets.only(right: 20, left: 20),
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: primary,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: primary,
                onTap: () => Get.toNamed("/login"),
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Continuar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: base,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
