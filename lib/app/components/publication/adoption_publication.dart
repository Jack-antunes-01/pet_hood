import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/components/tag_pet/tag_pet.dart';
import 'package:pet_hood/core/entities/pet_entity.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/utils/utils.dart';

class AdoptionPublication extends StatelessWidget {
  AdoptionPublication({Key? key}) : super(key: key);

  final String name = "Jackson Antunes Batista";
  final String username = "@Jack_antunes01";
  final String imageUrl = "assets/images/dog_image.png";
  final int age = 4;
  final String breed = "Vira-lata";
  final bool vaccinated = true;
  final double weight = 6.32;
  final PetCategory category = PetCategory.adoption;
  final DateTime postedAt = DateTime(2022, 04, 10);

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
                BuildPetFeature(value: "$age anos", feature: "Idade"),
                BuildPetFeature(value: breed, feature: "Raça"),
                BuildPetFeature(
                    value: vaccinated.toText(), feature: "Vacinado"),
                BuildPetFeature(value: "$weight Kg", feature: "Peso"),
                const SizedBox(width: 8),
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
            text: "Ver mais",
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
