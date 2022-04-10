import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/entities/pet.dart';
import 'package:pet_hood/routes/routes.dart';
import 'package:pet_hood/theme/colors.dart';

class PetProfileWidget extends StatelessWidget {
  const PetProfileWidget({
    Key? key,
    required this.pet,
    required this.index,
  }) : super(key: key);

  final Pet pet;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.petDetails, arguments: {
          "showAdoption": false,
          "name": pet.name,
          "location": pet.location,
          "distance": pet.distance,
          "category": pet.category,
          "imageUrl": pet.imageUrl,
          "favorite": pet.favorite,
          "newest": pet.newest,
        });
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
                    tag: pet.imageUrl,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://www.gettyimages.pt/gi-resources/images/500px/983794168.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: pet.favorite ? red : base,
                        ),
                        child: Icon(
                          Icons.favorite,
                          size: 16,
                          color: pet.favorite ? base : grey200,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                      left: 16,
                      top: 8,
                      bottom: 8,
                    ),
                    child: CustomText(
                      text: pet.name,
                      color: grey800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 8),
                      buildPetFeature(value: "4 anos", feature: "Idade"),
                      const SizedBox(width: 8),
                      buildPetFeature(value: "Vira-lata", feature: "Raça"),
                      const SizedBox(width: 8),
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

  Widget buildPetFeature({
    required String value,
    required String feature,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: grey200,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            CustomText(
              text: value,
              color: grey800,
              fontWeight: FontWeight.bold,
              textOverflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            CustomText(
              text: feature,
              color: grey600,
              fontSize: 15,
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
