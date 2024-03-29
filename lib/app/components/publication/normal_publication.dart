import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/components/pinch_to_zoom/pinch_to_zoom.dart';
import 'package:pet_hood/app/controllers/api_controller.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/post_entity.dart';
import "package:pet_hood/utils/utils.dart";

class NormalPublication extends StatelessWidget {
  final UserController _userController = Get.find();
  final PostEntity post;

  NormalPublication({
    Key? key,
    required this.post,
  }) : super(key: key);

  final likeKey = GlobalKey<LikeButtonState>();

  void likeFn() async {
    post.isLiked = !post.isLiked!;
    if (post.isLiked!) {
      post.qtLikes = post.qtLikes! + 1;
      await ApiController().likePost(postId: post.id);
    } else {
      post.qtLikes = post.qtLikes! - 1;
      await ApiController().deleteLikePost(postId: post.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: base,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),
          _content(context),
          _footer(),
        ],
      ),
    );
  }

  void openExternalProfile() async {
    await ApiController().goToExternalProfileById(userId: post.userId);
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
            child: GestureDetector(
              onTap: () => openExternalProfile(),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 15,
                    ),
                    child: post.isOwner
                        ? Obx(
                            () => UserAvatar(
                              size: 56,
                              avatar: _userController.userEntity.profileImage,
                            ),
                          )
                        : UserAvatar(
                            size: 56,
                            avatar: post.avatar,
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
                            text: post.name,
                            color: grey800,
                            fontSize: 18,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          CustomText(
                            text: "@${post.username}",
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
                  openBottomSheetModal(
                    context: context,
                    owner: post.isOwner,
                    post: post,
                  );
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

  Widget _content(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        post.pet?.description != null && post.pet!.description.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 15,
                ),
                child: CustomText(
                  text: post.pet!.description,
                  color: grey800,
                  fontSize: 16,
                ),
              )
            : const SizedBox.shrink(),
        GestureDetector(
          onDoubleTap: () {
            likeKey.currentState!.onTap();
          },
          child: PinchToZoom(
            child: SizedBox(
              height: height * 0.4,
              width: width,
              child: Image.network(
                '${dotenv.env["API_IMAGE"]}${post.pet!.petImage}',
                fit: BoxFit.cover,
              ),
            ),
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
                  key: likeKey,
                  size: 32,
                  isLiked: post.isLiked,
                  likeCount: post.qtLikes,
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
                  likeCountAnimationDuration: const Duration(microseconds: 0),
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

                    return post.isLiked;
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
              text: post.postedAt.postDate(post.postedAt),
              color: grey600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
