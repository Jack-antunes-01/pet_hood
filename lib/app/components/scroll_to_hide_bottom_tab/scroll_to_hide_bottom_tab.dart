import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:pet_hood/app/pages/home/home_page_controller.dart';

class ScrollToHideBottomTab extends StatefulWidget
    implements PreferredSizeWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;
  final bool isBottomTab;

  const ScrollToHideBottomTab({
    Key? key,
    required this.child,
    required this.controller,
    required this.isBottomTab,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  State<ScrollToHideBottomTab> createState() => _ScrollToHideBottomTabState();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class _ScrollToHideBottomTabState extends State<ScrollToHideBottomTab> {
  final HomePageController _homePageController = Get.find();

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);

    super.dispose();
  }

  void listen() {
    final direction = widget.controller.position.userScrollDirection;

    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse &&
        widget.controller.position.pixels >= 300) {
      hide();
    }
  }

  void show() {
    if (!_homePageController.isBottomTabVisible) {
      _homePageController.isBottomTabVisible = true;
    }
  }

  void hide() {
    if (_homePageController.isBottomTabVisible) {
      _homePageController.isBottomTabVisible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isBottomTab
        ? Obx(() => _buildBottomTab(context))
        : _buildAppBar(context);
  }

  Widget _buildBottomTab(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return AnimatedContainer(
      duration: widget.duration,
      height: _homePageController.isBottomTabVisible
          ? kBottomNavigationBarHeight + bottomPadding
          : 0,
      child: Wrap(
        children: [
          widget.child,
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return AnimatedContainer(
      duration: widget.duration,
      height: _homePageController.isBottomTabVisible ? 56 + topPadding : 0,
      child: widget.child,
    );
  }
}
