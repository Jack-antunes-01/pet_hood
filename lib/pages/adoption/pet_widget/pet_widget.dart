import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pet_hood/entities/pet.dart';
import 'package:pet_hood/routes/routes.dart';
import 'package:pet_hood/theme/colors.dart';

class PetWidget extends StatelessWidget {
  const PetWidget({
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
          "name": pet.name,
          "location": pet.location,
          "distance": pet.distance,
          "category": pet.category,
          "imageUrl": pet.imageUrl,
          "favorite": pet.favorite,
          "newest": pet.newest,
        });
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PetDetails(pet: pet),
        //   ),
        // );
      },
      child: Container(
        decoration: BoxDecoration(
          color: base,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(
            color: grey200,
            width: 1,
          ),
        ),
        width: 220,
        margin: EdgeInsets.only(
          right: index != null ? 16 : 0,
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
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: getBackgroundColor(pet.category),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      parsePetCondition(pet.category),
                      style: TextStyle(
                        color: getFontColor(pet.category),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    pet.name,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        pet.location,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "(" + pet.distance + ")",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
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
