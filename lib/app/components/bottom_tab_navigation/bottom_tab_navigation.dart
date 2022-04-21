import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:pet_hood/app/pages/home/home_page_controller.dart';
import 'package:pet_hood/app/pages/pages.dart';

import '../../theme/colors.dart';

class BottomTabNavigation extends StatelessWidget {
  BottomTabNavigation({Key? key}) : super(key: key);

  final HomePageController _homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: primary,
          selectedItemColor: base,
          unselectedItemColor: base,
          currentIndex: _homePageController.selectedIndex,
          selectedFontSize: 0,
          onTap: (index) {
            if (index == 2) {
              showGeneralDialog(
                transitionBuilder: (context, anim1, anim2, child) {
                  return SlideTransition(
                    position: Tween(
                            begin: const Offset(0, 1), end: const Offset(0, 0))
                        .animate(anim1),
                    child: child,
                  );
                },
                context: context,
                barrierColor: base, // Background color
                barrierDismissible: false,
                barrierLabel: 'Dialog',
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder: (_, __, ___) {
                  return PublicationPage();
                },
              );
            } else {
              _homePageController.selectedIndex = index;
            }
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.feed_outlined, size: 26),
              activeIcon: Icon(Icons.feed, size: 26),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined, size: 26),
              activeIcon: Icon(Icons.search, size: 30),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.post_add, size: 26),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/app_logo_outline.svg",
                width: 24,
              ),
              activeIcon: SvgPicture.asset(
                "assets/images/app_logo.svg",
                width: 24,
                color: base,
              ),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined, size: 26),
              activeIcon: Icon(Icons.account_circle, size: 26),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
