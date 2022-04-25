import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/core/entities/pet_entity.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/theme/colors.dart';

class PetWidget extends StatelessWidget {
  const PetWidget({
    Key? key,
    required this.pet,
    required this.index,
  }) : super(key: key);

  final PetEntity pet;
  final int index;

  @override
  Widget build(BuildContext context) {
    DateTime createdAtDate = pet.createdAt;
    var day = createdAtDate.day;
    var month = createdAtDate.month < 10
        ? "0${createdAtDate.month}"
        : createdAtDate.month;
    var year = createdAtDate.year;
    String createdAt = "$day/$month/$year";

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.petDetails,
          arguments: pet,
        );
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
          left: index == 0 ? 16 : 0,
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Hero(
                    tag: pet.petImage,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/dog_image.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    pet.name,
                    style: const TextStyle(
                      color: grey800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    pet.breed,
                    style: const TextStyle(
                      color: grey600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: grey600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        pet.city,
                        style: const TextStyle(
                          color: grey600,
                          fontSize: 12,
                        ),
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
