import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/core/entities/pet_entity.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/post_entity.dart';
import 'package:pet_hood/utils/utils.dart';

class AdoptionPublication extends StatelessWidget {
  final PostEntity post;

  AdoptionPublication({
    Key? key,
    required this.post,
  }) : super(key: key);

  final UserController _userController = Get.put(UserController());

  void seeMore() {
    Get.toNamed(
      Routes.petDetails,
      arguments: PetEntity(
        name: "Abyssinian Cats",
        city: "California",
        category: PetCategory.adoption,
        petImage: "assets/images/cats/cat_1.jpg",
        createdAt: DateTime.now(),
        age: DateTime(2021, 01, 01),
        breed: "Vira-lata",
        description: "Animal maravilhoso de fofo demais jentiiiiii",
        id: 'akosdopka',
        vaccine: true,
        userId: 'okasdpkosss',
      ),
    );
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
                          text: post.name,
                          color: grey800,
                          fontSize: 18,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        CustomText(
                          text: post.username,
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
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 15,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFeatures(),
              ],
            ),
          ),
        ),
        Stack(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(post.postImage),
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
            )
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
              text: "Ver mais",
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: base,
            ),
            onPress: () => seeMore(),
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

  Widget _buildFeatures() {
    return Row(
      children: [
        const SizedBox(width: 8),
        post.petName != null
            ? BuildPetFeature(value: post.petName!, feature: "Nome")
            : const SizedBox.shrink(),
        post.age != null
            ? BuildPetFeature(value: "${post.age} anos", feature: "Idade")
            : const SizedBox.shrink(),
        post.breed != null
            ? BuildPetFeature(value: post.breed!, feature: "Raça")
            : const SizedBox.shrink(),
        post.vaccine != null
            ? BuildPetFeature(
                value: post.vaccine!.toText(), feature: "Vacinado")
            : const SizedBox.shrink(),
        post.weight != null
            ? BuildPetFeature(value: "${post.weight} Kg", feature: "Peso")
            : const SizedBox.shrink(),
        const SizedBox(width: 8),
      ],
    );
  }
}
