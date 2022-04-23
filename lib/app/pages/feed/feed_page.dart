import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/pages/feed/feed_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/post_entity.dart';

class FeedPage extends StatelessWidget {
  final ScrollController controller;

  FeedPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final FeedController _feedController = Get.put(FeedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: inputColor,
      body: ListView.builder(
        controller: controller,
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (context, index) =>
            _buildFeed(_feedController.listPosts[index]),
        itemCount: _feedController.listPosts.length,
      ),
    );
  }

  Widget _buildFeed(PostEntity post) {
    if (post.type == PostTypeEnum.normal) {
      return NormalPublication(post: post);
    }

    if (post.type == PostTypeEnum.adoption) {
      return AdoptionPublication(post: post);
    }

    if (post.type == PostTypeEnum.disappear) {
      return MissingPublication(post: post);
    }

    if (post.type == PostTypeEnum.found) {
      return FoundPublication(post: post);
    }

    return const CustomText(
      text: "Houve um erro ao carregar este post..",
      color: grey800,
    );
  }
}
