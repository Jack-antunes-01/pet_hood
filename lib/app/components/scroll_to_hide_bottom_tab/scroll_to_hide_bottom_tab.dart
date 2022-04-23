import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  bool isVisible = true;

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
    if (!isVisible) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    return widget.isBottomTab
        ? _buildBottomTab(context)
        : _buildAppBar(context);
  }

  Widget _buildBottomTab(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return AnimatedContainer(
      duration: widget.duration,
      height: isVisible ? kBottomNavigationBarHeight + bottomPadding : 0,
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
      height: isVisible ? 56 + topPadding : 0,
      child: widget.child,
    );
  }

  // getHeight(BuildContext context) {
  //   final bottomPadding = MediaQuery.of(context).padding.bottom;
  //   final topPadding = MediaQuery.of(context).padding.top;

  //   if (widget.isBottomTab && isVisible) {
  //     return kBottomNavigationBarHeight + bottomPadding;
  //   } else if (isVisible) {
  //     return 50.0 + topPadding;
  //   }

  //   return 0.0;
  // }
}
