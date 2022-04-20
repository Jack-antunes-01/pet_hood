import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/components/tag_pet/tag_pet.dart';
import 'package:pet_hood/entities/pet.dart';
import 'package:pet_hood/routes/routes.dart';
import 'package:pet_hood/theme/colors.dart';
import 'package:pet_hood/utils/utils.dart';

class FoundPublication extends StatelessWidget {
  FoundPublication({Key? key}) : super(key: key);

  final String name = "Jackson Antunes Batista";
  final String username = "@Jack_antunes01";
  final String imageUrl = "assets/images/dog_image.png";
  final String dateFound = "13/03/2022";
  final String breed = "Vira-lata";
  final PetCategory category = PetCategory.found;
  final DateTime postedAt = DateTime(2022, 01, 02);

  final String description =
      "Animal encontrado 10:20 da manhã de hoje perto da rua das constelações no bairro jacarandá!";

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
                const Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    left: 15,
                  ),
                  child: UserAvatar(
                    size: 56,
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
                      children: const [
                        CustomText(
                          text: "Jackson Antunes Batista",
                          color: grey800,
                          fontSize: 18,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        CustomText(
                          text: "@Jack_antunes01",
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
                BuildPetFeature(value: dateFound, feature: "Encontrado"),
                BuildPetFeature(value: breed, feature: "Raça"),
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
            top: 10,
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
