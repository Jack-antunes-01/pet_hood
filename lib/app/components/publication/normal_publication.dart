import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import "package:pet_hood/utils/utils.dart";

class NormalPublication extends StatefulWidget {
  const NormalPublication({Key? key}) : super(key: key);

  @override
  State<NormalPublication> createState() => _NormalPublicationState();
}

class _NormalPublicationState extends State<NormalPublication> {
  final UserController _userController = Get.put(UserController());

  final String name = "Jackson Antunes Batista";
  final String username = "@Jack_antunes01";
  final String description = "Eu amo meu gatinho, ele é muito fofooooo!";
  final String imageUrl = "assets/images/dog_image.png";
  int qtLikes = 12;
  bool isLiked = false;
  final DateTime postedAt = DateTime(2022, 04, 19);

  final key = GlobalKey<LikeButtonState>();

  void likeFn() async {
    setState(() {
      isLiked = !isLiked;
      qtLikes += isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        color: base,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context),
            _content(),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 15,
                  ),
                  child: Obx(
                    () => UserAvatar(
                      size: 56,
                      avatar: _userController.profileImage,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: name,
                          color: grey800,
                          fontSize: 18,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        CustomText(
                          text: username,
                          color: grey600,
                          fontSize: 16,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 7,
              top: 7,
            ),
            child: Material(
              color: base,
              child: InkWell(
                splashColor: grey200,
                highlightColor: grey200,
                onTap: () {
                  openBottomSheetModal(context, true);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.more_vert,
                    color: grey800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 15,
          ),
          child: CustomText(
            text: description,
            color: grey800,
            fontSize: 16,
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            key.currentState!.onTap();
          },
          child: Stack(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _footer() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                child: LikeButton(
                  key: key,
                  size: 32,
                  isLiked: isLiked,
                  likeCount: qtLikes,
                  likeBuilder: (bool isLiked) {
                    return Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isLiked ? red : placeholder,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: isLiked ? base : base,
                        size: 18,
                      ),
                    );
                  },
                  countBuilder: (count, isLiked, text) {
                    return CustomText(
                      text: text,
                      color: grey600,
                      fontSize: 14,
                    );
                  },
                  likeCountPadding: const EdgeInsets.only(
                    left: 8,
                  ),
                  onTap: (isLiked) async {
                    likeFn();

                    return this.isLiked;
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 4,
                  right: 8,
                ),
                child: CustomText(
                  text: "curtidas",
                  color: grey600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
            ),
            child: CustomText(
              text: postedAt.postDate(),
              color: grey600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
