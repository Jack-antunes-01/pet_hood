import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/pet_details_controller.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/core/entities/pet_entity.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/theme/colors.dart';

class PetWidget extends StatelessWidget {
  final PetDetailsController _petDetailsController = Get.find();
  final UserController _userController = Get.find();

  PetWidget({
    Key? key,
    required this.pet,
    required this.index,
    this.isFilterScreen = false,
    this.isExternalProfile = false,
  }) : super(key: key);

  final PetEntity pet;
  final int index;
  final bool isFilterScreen;
  final bool isExternalProfile;

  @override
  Widget build(BuildContext context) {
    DateTime createdAtDate = pet.createdAt;
    var day = createdAtDate.day;
    var month = createdAtDate.month < 10
        ? "0${createdAtDate.month}"
        : createdAtDate.month;
    var year = createdAtDate.year;
    String createdAt = "$day/$month/$year";

    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        _petDetailsController.setPet(
          pet: pet,
          userId: _userController.userEntity.id,
          isExternalProfile: isExternalProfile,
        );
        Get.toNamed(Routes.petDetails);
      },
      child: Container(
        decoration: BoxDecoration(
          color: base,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
          border: Border.all(
            color: grey200,
            width: 1,
          ),
        ),
        width: 230,
        margin: EdgeInsets.only(
          right: 16,
          left: !isFilterScreen && index == 0 ? 16 : 0,
          bottom: 16,
        ),
        // child: CustomText(text: "ksaopdspoa", color: grey800),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Hero(
                  tag: isExternalProfile ? 'p${pet.petImage!}' : pet.petImage!,
                  child: SizedBox(
                    height: isFilterScreen ? 230 : 150,
                    width: width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        '${dotenv.env["API_IMAGE"]}${pet.petImage}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TagPet(category: pet.category),
                      CustomText(
                        text: createdAt,
                        color: grey800,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    text: pet.name != null && pet.name!.isNotEmpty
                        ? pet.name!
                        : getPetNameWhenEmpty(),
                    color: grey800,
                    fontWeight: FontWeight.bold,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  CustomText(
                    text: pet.breed!,
                    color: grey600,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: grey600,
                      ),
                      CustomText(
                        text: '${pet.city} / ${pet.state}',
                        color: grey600,
                        fontSize: 14,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getPetNameWhenEmpty() {
    switch (pet.category) {
      case PetCategory.adoption:
        return "Pet para adoção";
      case PetCategory.disappear:
        return "Pet desaparecido";
      case PetCategory.found:
        return "Pet encontrado";
      default:
        return "Meu nome está vazio :(";
    }
  }

  getBackgroundColor(PetCategory category) {
    switch (category) {
      case PetCategory.adoption:
        return adoptionBackground;
      case PetCategory.disappear:
        return forgottenBackground;
      case PetCategory.found:
        return foundBackground;
      default:
        return primary;
    }
  }

  getFontColor(PetCategory category) {
    switch (category) {
      case PetCategory.adoption:
        return adoptionFont;
      case PetCategory.disappear:
        return forgottenFont;
      case PetCategory.found:
        return foundFont;
      default:
        return primaryDark;
    }
  }

  parsePetCondition(PetCategory category) {
    switch (category) {
      case PetCategory.adoption:
        return "Adoção";
      case PetCategory.disappear:
        return "Desaparecido";
      case PetCategory.found:
        return "Encontrado";
      default:
        return "UNKNOWN";
    }
  }
}
