import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/api_controller.dart';
import 'package:pet_hood/app/pages/feed/feed_controller.dart';
import 'package:pet_hood/app/pages/home/home_page_controller.dart';
import 'package:pet_hood/app/pages/pages.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/theme/colors.dart';

List<Widget> _pages(ScrollController controller) => [
      FeedPage(controller: controller),
      SearchPage(),
      const SizedBox.shrink(),
      const AdoptionPage(),
      const ProfilePage(isOwner: true),
    ];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController _homePageController = Get.put(HomePageController());
  final FeedController _feedController = Get.find();

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  _scrollListener() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if (!_feedController.maxPostsReached) {
        try {
          _feedController.loadMoreFeed = true;
          await ApiController().getFeedPosts(
            page: _feedController.page,
          );
        } on DioError catch (e) {
          _feedController.loadMoreFeed = false;
          Get.snackbar(
            "Erro",
            e.message.toString(),
            backgroundColor: primary,
            colorText: base,
            duration: const Duration(seconds: 2),
          );
        }
        _feedController.loadMoreFeed = false;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Vai nos deixar? 🥺'),
            content: const Text('Você quer sair do app'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Não'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Sim'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: const DrawerNavigation(),
        appBar: _appBar(),
        bottomNavigationBar: ScrollToHideBottomTab(
          controller: _controller,
          child: BottomTabNavigation(),
          isBottomTab: true,
        ),
        body: Obx(
          () => Container(
            child: _pages(_controller)
                .elementAt(_homePageController.selectedIndex),
          ),
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
