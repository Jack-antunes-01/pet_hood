import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/components/user_avatar/user.avatar.dart';
import 'package:pet_hood/entities/pet.dart';
import 'package:pet_hood/theme/colors.dart';

class PetDetails extends StatelessWidget {
  PetDetails({
    Key? key,
  }) : super(key: key);

  final showAdoption = Get.arguments["showAdoption"];
  final Pet pet = Pet(
    name: Get.arguments['name'],
    location: Get.arguments['location'],
    distance: Get.arguments['distance'],
    category: Get.arguments['category'],
    imageUrl: Get.arguments['imageUrl'],
    favorite: Get.arguments['favorite'],
    newest: Get.arguments['newest'],
  );

  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.bottom;
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
                  Padding(
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
                                  pet.location,
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
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        buildPetFeature(value: "4 anos", feature: "Idade"),
                        buildPetFeature(value: "Vira-lata", feature: "Raça"),
                        buildPetFeature(value: "Sim", feature: "Vacinado"),
                        buildPetFeature(value: "6 Kg", feature: "Peso"),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomText(
                      text:
                          "O tom é muito fofo quando se trata de ser o melhor gato da família! Todos aqui em casa amam ele :)",
                      color: grey600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: 16,
                      bottom: safePadding + 10,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
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
                  ),
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
      // leading:
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: pet.favorite ? red : base,
            ),
            child: Icon(
              Icons.favorite,
              size: 18,
              color: pet.favorite ? base : grey200,
            ),
          ),
        ),
      ],
    );
  }

  Widget _petImage(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Hero(
          tag: pet.imageUrl,
          child: Container(
            height: height * 0.5,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://www.gettyimages.pt/gi-resources/images/500px/983794168.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPetFeature({
    required String value,
    required String feature,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
              fontSize: 18,
            ),
            const SizedBox(height: 4),
            CustomText(
              text: feature,
              color: grey600,
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}
