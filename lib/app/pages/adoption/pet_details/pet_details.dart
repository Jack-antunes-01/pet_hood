import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/core/entities/pet_entity.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/utils/utils.dart';

class PetDetails extends StatelessWidget {
  PetDetails({
    Key? key,
  }) : super(key: key);

  final showAdoption = true;
  final PetEntity pet = PetEntity(
    id: Get.arguments.id,
    userId: Get.arguments.userId,
    name: Get.arguments.name,
    breed: Get.arguments.breed,
    vaccine: Get.arguments.vaccine,
    description: Get.arguments.description,
    age: Get.arguments.age,
    city: Get.arguments.city,
    petImage: Get.arguments.petImage,
    category: Get.arguments.category,
    createdAt: Get.arguments.createdAt,
  );

  void openExternalProfile() => Get.toNamed(Routes.externalProfile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _petImage(context),
            Container(
              color: base,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  _content(),
                  _footer(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: base,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.arrow_back,
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

  Widget _petImage(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Hero(
          tag: pet.petImage,
          child: Container(
            height: height * 0.5,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/dog_image.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        left: 20,
        top: 16,
        bottom: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pet.name,
                style: const TextStyle(
                  color: grey800,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
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
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          showAdoption
              ? Material(
                  color: primary,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: primary.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 0),
                          )
                        ],
                      ),
                      child: const CustomText(
                        text: "Me adote",
                        color: base,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 12),
              BuildPetFeature(value: pet.age.toYearOrMonth(), feature: "Idade"),
              BuildPetFeature(value: pet.breed, feature: "Raça"),
              BuildPetFeature(value: pet.vaccine.toText(), feature: "Vacinado"),
              // BuildPetFeature(value: "6 Kg", feature: "Peso"),
              const SizedBox(width: 12),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            right: 20,
            left: 20,
            top: 16,
            bottom: 8,
          ),
          child: CustomText(
            text: "Descrição",
            color: grey800,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomText(
            text: pet.description,
            color: grey600,
          ),
        ),
      ],
    );
  }

  Widget _footer(context) {
    var safePadding = MediaQuery.of(context).padding.bottom;
    return Padding(
      padding: EdgeInsets.only(
        right: 20,
        left: 20,
        top: 16,
        bottom: safePadding + 10,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => openExternalProfile(),
            child: const UserAvatar(),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomText(
                text: "Publicação feita por",
                color: grey800,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: "Jackson Antunes",
                color: grey600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}