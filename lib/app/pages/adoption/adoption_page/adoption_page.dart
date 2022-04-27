import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/adoption_controller.dart';
import 'package:pet_hood/core/entities/pet_entity.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/utils/utils.dart';

class AdoptionPage extends StatefulWidget {
  const AdoptionPage({Key? key}) : super(key: key);

  @override
  State<AdoptionPage> createState() => _AdoptionPageState();
}

class _AdoptionPageState extends State<AdoptionPage> {
  final AdoptionController _adoptionPageController = Get.find();

  late List<PetEntity> pets;

  @override
  void initState() {
    super.initState();
    pets = _adoptionPageController.petList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _petCategory(),
          _newestPets(),
        ],
      ),
    );
  }

  Widget _petCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 15, left: 15, top: 20),
          child: CustomText(
            text: "Animais",
            color: grey800,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            children: [
              buildPetCategory(PetCategory.adoption),
              buildPetCategory(PetCategory.disappear),
              buildPetCategory(PetCategory.found),
            ],
          ),
        ),
      ],
    );
  }

  Widget _newestPets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(15),
          child: CustomText(
            text: "Novos Pets",
            color: grey800,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 300,
          child: Obx(
            () => ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: _buildList(),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildList() {
    if (pets.isNotEmpty) {
      return _buildNewestPet();
    }
    return [
      const Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: CustomText(
          text: "Não há novos pets no momento.",
          color: grey800,
        ),
      ),
    ];
  }

  List<Widget> _buildNewestPet() {
    List<Widget> list = [];

    for (var i = 0; i < pets.length; i++) {
      if (pets[i].createdAt.verifyNewest()) {
        list.add(
          PetWidget(
            pet: pets[i],
            index: i,
          ),
        );
      }
    }

    return list;
  }

  Widget buildPetCategory(PetCategory petCategory) {
    getPetImage() {
      switch (petCategory) {
        case PetCategory.found:
          return "hamster";
        case PetCategory.disappear:
          return "cat";
        case PetCategory.adoption:
          return "dog";
        default:
          return "unknown";
      }
    }

    return GestureDetector(
      onTap: () {
        _adoptionPageController.petCategory = petCategory;
        Get.toNamed(Routes.categoryList);
      },
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: grey200,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primary.withOpacity(0.3),
              ),
              child: Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    "assets/images/" + getPetImage() + ".png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              parsePetCondition(petCategory),
              style: const TextStyle(
                color: grey800,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
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

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
