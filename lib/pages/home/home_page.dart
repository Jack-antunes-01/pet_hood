import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:pet_hood/components/bottom_tab_navigation/bottom_tab_navigation.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/components/drawer_navigation/drawer_navigation.dart';
import 'package:pet_hood/pages/home/home_page_controller.dart';
import 'package:pet_hood/pages/pages.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomePageController _homePageController = Get.put(HomePageController());

  final List<Widget> _pages = const [
    FeedPage(),
    SearchPage(),
    SizedBox.shrink(),
    AdoptionPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerNavigation(),
      appBar: _appBar(),
      bottomNavigationBar: BottomTabNavigation(),
      body: Obx(
        () => Center(
          child: _pages.elementAt(_homePageController.selectedIndex),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(items: []),
    );
  }

  Widget _chatButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: IconButton(
        splashRadius: 25,
        icon: const Icon(Icons.chat_outlined, size: 28),
        onPressed: () {},
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBarHeader(
      appBar: AppBar(),
      leading: Builder(
        builder: (BuildContext context) => IconButton(
          splashRadius: 25,
          icon: const Icon(Icons.menu_rounded, size: 32),
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
      ),
      actions: [
        _chatButton(),
      ],
    );
  }
}
