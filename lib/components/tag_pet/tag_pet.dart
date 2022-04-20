import 'package:flutter/material.dart';
import 'package:pet_hood/entities/pet.dart';
import 'package:pet_hood/theme/colors.dart';

class TagPet extends StatelessWidget {
  final PetCategory category;

  const TagPet({
    Key? key,
    required this.category,
  }) : super(key: key);

  getBackgroundColor() {
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

  getFontColor() {
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

  getPetText() {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getBackgroundColor(),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        getPetText(),
        style: TextStyle(
          color: getFontColor(),
          fontSize: 12,
        ),
      ),
    );
  }
}
