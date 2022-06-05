import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/components/publication_create/widgets/city_state_publication.dart';
import 'package:pet_hood/app/components/publication_create/widgets/description_create_publication.dart';
import 'package:pet_hood/app/controllers/adoption_controller.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/pages/feed/feed_controller.dart';
import 'package:pet_hood/app/pages/home/home_page_controller.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/entities.dart';
import 'package:pet_hood/utils/regex/only_letters.dart';

class CreateFoundPublication extends StatefulWidget {
  const CreateFoundPublication({Key? key}) : super(key: key);

  @override
  State<CreateFoundPublication> createState() => _CreateFoundPublicationState();
}

class _CreateFoundPublicationState extends State<CreateFoundPublication> {
  final PublicationPageController _publicationPageController = Get.find();
  final UserController _userController = Get.find();
  final FeedController _feedController = Get.find();
  final AdoptionController _adoptionController = Get.find();
  final HomePageController _homePageController = Get.find();

  final formKey = GlobalKey<FormState>();

  validateForm() async {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      if (_publicationPageController.petImage.path.isNotEmpty) {
        _publicationPageController.loadingPublication = true;
        await Future.delayed(const Duration(seconds: 2), () {});
        final UserEntity user = _userController.userEntity;
        final String breed = _publicationPageController.breedController.text;
        final String city = _publicationPageController.cityController.text;
        final String state = _publicationPageController.stateController.text;
        final String description =
            _publicationPageController.descriptionController.text.trim();
        final File petImage = _publicationPageController.petImage;

        final PostEntity postEntity = PostEntity(
          id: Random().nextInt(9999).toString(),
          type: PostTypeEnum.found,
          name: user.name,
          avatar: user.profileImage!,
          username: user.userName,
          isOwner: true,
          postImageFile: petImage,
          description: description,
          postedAt: DateTime.now(),
          pet: PetEntity(
            breed: breed,
            userId: _userController.userEntity.id,
            id: Random().nextInt(9999).toString(),
            description: description,
            createdAt: DateTime.now(),
            category: PetCategory.found,
            petImageFile: petImage,
            state: state,
            city: city,
            petOwnerName: user.name,
            petOwnerImage: user.profileImage,
          ),
        );

        _homePageController.selectedIndex = 0;
        _feedController.addPost(postEntity);
        _adoptionController.addNewPet(postEntity.pet!);
        _userController.addNewPost(postEntity);

        _publicationPageController.reset();
        Get.back();
      } else {
        Get.snackbar(
          "Imagem",
          "Adicione uma imagem para continuar",
          duration: const Duration(seconds: 2),
          backgroundColor: primary,
          colorText: base,
        );
      }
    } else {
      Get.snackbar(
        "Campos não preenchidos",
        "Preencha todos os campos para continuar",
        duration: const Duration(seconds: 2),
        backgroundColor: primary,
        colorText: base,
      );
    }
  }

  bool validation = false;

  @override
  Widget build(BuildContext context) {
    var safePaddingBottom = MediaQuery.of(context).padding.bottom;
    var height = MediaQuery.of(context).size.height;
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomInput(
                          controller:
                              _publicationPageController.breedController,
                          placeholderText: "Raça",
                          validator: (breed) =>
                              breed != null && breed.isNotEmpty
                                  ? null
                                  : "Digite a raça",
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              onlyLettersWithBlank,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const CityStatePublication(),
              ],
            ),
          ),
          DescriptionCreatePublication(),
          Padding(
            padding: EdgeInsets.only(
              bottom: safePaddingBottom + height * 0.05,
              left: 20,
              right: 20,
            ),
            child: CustomButton(
              child: Obx(() => _buildButtonOrLoading()),
              onPress: () => validateForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonOrLoading() {
    if (_publicationPageController.loadingPublication) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: base,
        ),
      );
    }

    return CustomText(
      text: _publicationPageController.isChangePublicationTypeEnabled
          ? "Publicar"
          : "Salvar",
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: base,
    );
  }
}
