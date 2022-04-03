import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/constants/constants.dart';
import 'package:pet_hood/theme/colors.dart';

class AppBarHeader extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final AppBar appBar;
  final String? title;
  final VoidCallback? onBackPress;

  const AppBarHeader({
    Key? key,
    this.leading,
    this.actions,
    required this.appBar,
    this.onBackPress,
    this.title,
  }) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leading: onBackPress != null ? _leading() : leading,
      actions: actions,
      elevation: 0,
      centerTitle: title != null ? false : true,
      backgroundColor: primary,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: title != null
                ? CustomText(
                    text: title!,
                    color: base,
                    fontSize: 18,
                  )
                : const Text(
                    appTitle,
                    style: TextStyle(
                      color: base,
                      fontFamily: "Grand Hotel",
                      fontSize: 24,
                    ),
                  ),
          ),
          title != null
              ? const SizedBox.shrink()
              : SvgPicture.asset(
                  "assets/images/app_logo.svg",
                  width: 32,
                  color: base,
                ),
        ],
      ),
    );
  }

  Widget _leading() {
    if (Platform.isAndroid) {
      return IconButton(
        splashRadius: 25,
        onPressed: onBackPress,
        icon: const Icon(
          Icons.arrow_back,
          color: base,
        ),
      );
    } else if (Platform.isIOS) {
      return IconButton(
        splashRadius: 25,
        onPressed: onBackPress,
        icon: const Icon(
          Icons.arrow_back_ios,
          color: base,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
