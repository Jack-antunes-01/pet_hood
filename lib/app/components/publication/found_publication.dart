import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/pinch_to_zoom/pinch_to_zoom.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/core/entities/pet_entity.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/post_entity.dart';
import 'package:pet_hood/utils/utils.dart';

class FoundPublication extends StatelessWidget {
  final UserController _userController = Get.find();
  final PostEntity post;

  FoundPublication({
    Key? key,
    required this.post,
  }) : super(key: key);

  void goToChat() => Get.toNamed(Routes.chatPeople);

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
        Padding(
          padding: const EdgeInsets.only(
            bottom: 15,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFeature(),
              ],
            ),
          ),
        ),
        post.pet?.description != null && post.pet!.description.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
                child: CustomText(
                  text: post.pet!.description,
                  color: grey800,
                ),
              )
            : const SizedBox.shrink(),
        Stack(
          children: [
            PinchToZoom(
              child: SizedBox(
                height: height * 0.4,
                width: width,
                child: Image.network(
                  '${dotenv.env["API_IMAGE"]}${post.postImage}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 15,
              child: TagPet(
                category: PetCategory.values.firstWhere(
                  (element) => element.name == post.type.name,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _footer() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 15,
            right: 15,
            left: 15,
            bottom: 10,
          ),
          child: CustomButton(
            child: const CustomText(
              text: "Contate-me",
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: base,
            ),
            onPress: () => goToChat(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
                bottom: 8,
              ),
              child: CustomText(
                text: post.postedAt.postDate(),
                color: grey600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeature() {
    return Row(
      children: [
        const SizedBox(width: 8),
        post.pet?.breed != null
            ? BuildPetFeature(value: post.pet!.breed!, feature: "Raça")
            : const SizedBox.shrink(),
        post.pet?.city != null
            ? BuildPetFeature(value: post.pet!.city, feature: "Cidade")
            : const SizedBox.shrink(),
        post.pet?.state != null
            ? BuildPetFeature(value: post.pet!.state, feature: "Estado")
            : const SizedBox.shrink(),
        const SizedBox(width: 8),
      ],
    );
  }
}
