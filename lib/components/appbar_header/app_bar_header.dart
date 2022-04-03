import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_hood/theme/colors.dart';

PreferredSizeWidget appBarHeader() {
  return AppBar(
    centerTitle: true,
    backgroundColor: primary,
    elevation: 1,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Text(
            "Pet Hood",
            style: TextStyle(
              color: base,
              fontFamily: "Grand Hotel",
              fontSize: 24,
            ),
          ),
        ),
        SvgPicture.asset(
          "assets/images/app_logo.svg",
          width: 32,
          color: base,
        ),
      ],
    ),
  );
}
