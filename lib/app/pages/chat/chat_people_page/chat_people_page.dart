import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/theme/colors.dart';

class ChatPeoplePage extends StatelessWidget {
  final UserController _userController = Get.find();

  ChatPeoplePage({Key? key}) : super(key: key);

  void openExternalProfile() => Get.toNamed(Routes.externalProfile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        elevation: 0,
        titleSpacing: 0,
        title: _appBarTitle(),
      ),
      body: Column(
        children: [
          const Expanded(child: ChatList()),
          _chatInput(context),
        ],
      ),
    );
  }

  Widget _appBarTitle() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: 4,
        ),
        child: Row(
          children: [
            IconButton(
              splashRadius: 20,
              onPressed: () {
                Get.back();
              },
              icon: Platform.isIOS
                  ? const Icon(Icons.arrow_back_ios)
                  : const Icon(Icons.arrow_back),
            ),
            Expanded(
              child: InkWell(
                onTap: () => openExternalProfile(),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                    left: 4,
                  ),
                  child: Row(
                    children: [
                      Obx(
                        () => UserAvatar(
                          size: 40,
                          useBorder: false,
                          avatar: _userController.profileImage,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 8,
                          right: 8,
                        ),
                        child: CustomText(
                          text: "Jackson Antunes",
                          color: base,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chatInput(BuildContext context) {
    final double bottomPadding =
        MediaQuery.of(context).viewInsets.bottom > 50 ? 0 : 25;

    return Padding(
      padding: EdgeInsets.only(
        bottom: Platform.isIOS ? bottomPadding : 0,
      ),
      child: Container(
        height: 48,
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            Flexible(
              child: Material(
                borderRadius: BorderRadius.circular(40),
                color: primary,
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        style: const TextStyle(color: base),
                        decoration: InputDecoration(
                          hintText: "Escreva uma mensagem..",
                          hintStyle: const TextStyle(color: base),
                          contentPadding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 20,
                            right: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 5),
            InkWell(
              borderRadius: BorderRadius.circular(360),
              onTap: () {},
              child: Ink(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
