import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/routes/routes.dart';
import 'package:pet_hood/theme/colors.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        appBar: AppBar(),
      ),
      body: _buildChatBody(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.chat,
          color: base,
        ),
        onPressed: () {},
        elevation: 0,
        backgroundColor: primary,
        highlightElevation: 0,
      ),
    );
  }

  Widget _buildChatBody() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 20, left: 20, top: 16, bottom: 16),
          child: CustomInput(
            placeholderText: "Digite algo..",
            prefixIcon: Icon(Icons.search, color: grey600),
            labelActive: false,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: Column(
                children: List.generate(7, (index) => _chatPeople()),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _chatPeople() {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Get.toNamed(Routes.chatPeople);
      },
      splashColor: grey200,
      highlightColor: grey200,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: grey200,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: UserAvatar(
                size: 55,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CustomText(
                        text: "Jackson Antunes",
                        color: grey800,
                        fontSize: 18,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 20),
                        child: CustomText(
                          text: "17:10",
                          color: grey800,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.done,
                            color: primary,
                            size: 14,
                          ),
                          CustomText(text: "Adorei seu pet :)", color: grey600),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 20,
                        ),
                        child: Container(
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const CustomText(
                            color: base,
                            text: "2",
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
