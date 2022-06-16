import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/api_controller.dart';
import 'package:pet_hood/app/pages/feed/feed_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/entities.dart';

class FeedPage extends StatelessWidget {
  final ScrollController controller;

  FeedPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final FeedController _feedController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: inputColor,
      body: Obx(
        () => _feedController.loadingFeed
            ? _buildLoading()
            : RefreshIndicator(
                onRefresh: _refreshList,
                child: ListView.builder(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  itemBuilder: (context, index) {
                    if (index > _feedController.listPosts.length - 1 &&
                        _feedController.maxPostsReached) {
                      return const SizedBox.shrink();
                    }
                    if (index > _feedController.listPosts.length - 1) {
                      return _buildCustomLoading();
                    }

                    return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _buildFeed(_feedController.listPosts[index]));
                  },
                  itemCount: _feedController.listPosts.length + 1,
                ),
              ),
      ),
    );
  }

  Widget _buildCustomLoading() {
    return const SizedBox(
      width: 100,
      height: 100,
      child: Center(
        child: CircularProgressIndicator(
          color: primary,
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          color: primary,
        ),
      ),
    );
  }

  Future<void> _refreshList() async {
    try {
      _feedController.page = 0;
      await ApiController().getFeedPosts(page: _feedController.page);
    } on DioError catch (e) {
      Get.snackbar(
        "Erro",
        e.message.toString(),
        duration: const Duration(
          seconds: 2,
        ),
        backgroundColor: primary,
        colorText: base,
      );
    }
  }

  Widget _buildFeed(PostEntity post) {
    if (post.pet!.category == PetCategory.normal) {
      return NormalPublication(post: post);
    }

    if (post.pet!.category == PetCategory.adoption) {
      return AdoptionPublication(post: post);
    }

    if (post.pet!.category == PetCategory.disappear) {
      return MissingPublication(post: post);
    }

    if (post.pet!.category == PetCategory.found) {
      return FoundPublication(post: post);
    }

    return const CustomText(
      text: "Houve um erro ao carregar este post..",
      color: grey800,
    );
  }
}
