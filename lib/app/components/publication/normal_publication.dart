import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/post_entity.dart';
import "package:pet_hood/utils/utils.dart";

class NormalPublication extends StatelessWidget {
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
    } else {
      post.qtLikes = post.qtLikes! - 1;
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
                  child: UserAvatar(
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

  Widget _content(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        post.description != null && post.description!.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 15,
                ),
                child: CustomText(
                  text: post.description!,
                  color: grey800,
                  fontSize: 16,
                ),
              )
            : const SizedBox.shrink(),
        GestureDetector(
          onDoubleTap: () {
            likeKey.currentState!.onTap();
          },
          child: Stack(
            children: [
              post.postImage != null
                  ? Container(
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(post.postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 300,
                      width: width,
                      child: Image.file(
                        post.postImageFile!,
                        fit: BoxFit.cover,
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
              text: post.postedAt.postDate(),
              color: grey600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
