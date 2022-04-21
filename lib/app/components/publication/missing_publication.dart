import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/core/entities/pet_entity.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/utils/utils.dart';

class MissingPublication extends StatelessWidget {
  final UserController _userController = Get.put(UserController());

  MissingPublication({Key? key}) : super(key: key);

  final String name = "Jackson Antunes Batista";
  final String username = "@Jack_antunes01";
  final String imageUrl = "assets/images/dog_image.png";
  final String dateMissing = "13/03/2022";
  final String petName = "Sansão";
  final String breed = "Vira-lata";
  final int age = 4;
  final PetCategory category = PetCategory.disappear;

  final String description =
      "Perdi meu animal perto da faculdade uniube, por favor, estamos desesperados! Aproximadamente 11:30 da manhã!";

  final postedAt = DateTime(2022, 04, 02);

  void goToChat() => Get.toNamed(Routes.chatPeople);

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
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 15,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 8),
                BuildPetFeature(value: dateMissing, feature: "Perdido"),
                BuildPetFeature(value: petName, feature: "Nome"),
                BuildPetFeature(value: breed, feature: "Raça"),
                BuildPetFeature(value: "$age ano(s)", feature: "Idade"),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
          child: CustomText(
            text: description,
            color: grey800,
          ),
        ),
        Stack(
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
            Positioned(
                bottom: 15,
                left: 15,
                child: TagPet(
                  category: category,
                ))
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
            text: "Contate-me",
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
                text: postedAt.postDate(),
                color: grey600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
