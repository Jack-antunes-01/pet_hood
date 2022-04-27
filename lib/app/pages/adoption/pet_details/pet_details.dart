import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/components/expandable_text/expandable_text.dart';
import 'package:pet_hood/app/components/pinch_to_zoom/pinch_to_zoom.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/core/entities/pet_entity.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/utils/utils.dart';

class PetDetails extends StatelessWidget {
  final UserController _userController = Get.find();

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
    yearOrMonth: Get.arguments.yearOrMonth,
    city: Get.arguments.city,
    state: Get.arguments.state,
    petImage: Get.arguments.petImage,
    petImageFile: Get.arguments.petImageFile,
    category: Get.arguments.category,
    createdAt: Get.arguments.createdAt,
    petOwnerName: Get.arguments.petOwnerName,
    petOwnerImage: Get.arguments.petOwnerImage,
  );

  void openExternalProfile() => Get.toNamed(Routes.externalProfile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _petImage(context),
                  Expanded(
                    child: Container(
                      color: base,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _header(),
                          _content(),
                          const Spacer(),
                          _footer(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Hero(
          tag: pet.petImage != null && pet.petImage!.isNotEmpty
              ? pet.petImage!
              : pet.petImageFile!.path,
          child: PinchToZoom(
            child: pet.petImage != null
                ? Container(
                    height: height * 0.5,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/dog_image.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : SizedBox(
                    height: height * 0.5,
                    width: width,
                    child: Image.file(
                      pet.petImageFile!,
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
                pet.name!,
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
                    "${pet.city}/${pet.state}",
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
                    onTap: () => Get.toNamed(Routes.chatPeople),
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
              BuildPetFeature(value: pet.age.toString(), feature: "Idade"),
              BuildPetFeature(value: pet.breed!, feature: "Raça"),
              pet.vaccine != null
                  ? BuildPetFeature(
                      value: pet.vaccine!.toText(), feature: "Vacinado")
                  : const SizedBox.shrink(),
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
          child: ExpandableText(
            text: pet.description.isNotEmpty
                ? pet.description
                : "Não há informações adicionais sobre esse pet.",
          ),
        )
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
            child: UserAvatar(
              avatarFile: pet.userId == _userController.userEntity.id
                  ? pet.petOwnerImageFile
                  : _userController.profileImage,
              avatar: pet.userId == _userController.userEntity.id
                  ? pet.petOwnerImage
                  : _userController.userEntity.profileImage,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: "Publicação feita por",
                color: grey800,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: pet.petOwnerName,
                color: grey600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
