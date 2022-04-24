import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/pages/home/home_page_controller.dart';
import 'package:pet_hood/app/pages/pages.dart';
import 'package:pet_hood/app/routes/routes.dart';

List<Widget> _pages(ScrollController controller) => [
      FeedPage(controller: controller),
      SearchPage(),
      const SizedBox.shrink(),
      AdoptionPage(),
      const ProfilePage(isOwner: true),
    ];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController _homePageController = Get.put(HomePageController());

  late ScrollController controller;

  @override
  void initState() {
    super.initState();

    controller = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerNavigation(),
      appBar: _appBar(),
      bottomNavigationBar: ScrollToHideBottomTab(
        controller: controller,
        child: BottomTabNavigation(),
        isBottomTab: true,
      ),
      body: Obx(
        () => Container(
          child:
              _pages(controller).elementAt(_homePageController.selectedIndex),
        ),
      ),
    );
  }

  Widget _chatButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: IconButton(
        splashRadius: 25,
        icon: const Icon(Icons.chat_outlined, size: 28),
        onPressed: () {
          Get.toNamed(Routes.chat);
        },
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
