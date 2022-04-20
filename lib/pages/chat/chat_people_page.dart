import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/pages/chat/chat_list/chat_list.dart';
import 'package:pet_hood/routes/routes.dart';
import 'package:pet_hood/theme/colors.dart';

class ChatPeoplePage extends StatelessWidget {
  const ChatPeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double bottomPadding =
        MediaQuery.of(context).viewInsets.bottom > 50 ? 0 : 25;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: const [
            UserAvatar(
              size: 40,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: CustomText(
                text: "Jackson Antunes",
                color: base,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.more_vert, color: base),
            onPressed: () {
              _openBottomSheetModal(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(child: ChatList()),
          Padding(
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
                      borderRadius: BorderRadius.circular(4),
                      color: primary,
                      child: Row(
                        children: const [
                          Flexible(
                            child: TextField(
                              style: TextStyle(color: base),
                              decoration: InputDecoration(
                                hintText: "Escreva uma mensagem..",
                                hintStyle: TextStyle(color: base),
                                contentPadding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  left: 20,
                                  right: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
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
          ),
        ],
      ),
    );
  }

  _openBottomSheetModal(context) {
    var safePadding = MediaQuery.of(context).padding.bottom;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Padding(
            padding: EdgeInsets.only(bottom: safePadding),
            child: Theme(
              data: ThemeData(
                splashColor: grey200,
                highlightColor: grey200,
              ),
              child: Wrap(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: CustomText(text: "Opções", color: grey800),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.account_circle_outlined,
                      color: grey800,
                    ),
                    title: const CustomText(text: 'Ver perfil', color: grey800),
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.toNamed(Routes.externalProfile);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
