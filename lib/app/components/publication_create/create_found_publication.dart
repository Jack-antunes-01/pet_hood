import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/components/publication_create/widgets/city_state_publication.dart';
import 'package:pet_hood/app/components/publication_create/widgets/description_create_publication.dart';
import 'package:pet_hood/app/controllers/adoption_controller.dart';
import 'package:pet_hood/app/controllers/api_controller.dart';
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
      if (_publicationPageController.isChangePublicationTypeEnabled) {
        await savePost();
      } else {
        await updatePost();
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

  Future<void> savePost() async {
    if (_publicationPageController.petImage.path.isNotEmpty) {
      _publicationPageController.loadingPublication = true;
      final UserEntity user = _userController.userEntity;
      final String breed = _publicationPageController.breedController.text;
      final String city = _publicationPageController.cityController.text;
      final String state = _publicationPageController.stateController.text;
      final String description =
          _publicationPageController.descriptionController.text.trim();
      final File petImage = _publicationPageController.petImage;

      try {
        final responsePet = await ApiController().savePet(
          breed: breed,
          petName: '',
          age: null,
          vaccine: false,
          yearOrMonth: YearOrMonth.years,
          description: description,
          state: state,
          city: city,
          petImage: petImage,
          petCategory: PetCategory.found,
        );

        final responsePost = await ApiController().addPost(
          imageId: responsePet['petImage'],
          petId: responsePet['petId'],
          petCategory: PetCategory.found,
        );

        if (responsePost['postId'] != null &&
            responsePet['petId'] != null &&
            responsePet['petImage'] != null) {
          // final PostEntity temp = _publicationPageController.postEntityTemp;
          final DateTime timeNow = DateTime.now().add(const Duration(hours: 6));
          final PostEntity postEntity = PostEntity(
            id: responsePost['postId'],
            userId: _userController.userEntity.id,
            name: user.name,
            avatar: user.profileImage != null ? user.profileImage! : '',
            username: user.userName,
            isOwner: true,
            postedAt: timeNow,
            pet: PetEntity(
              userId: _userController.userEntity.id,
              breed: breed,
              age: null,
              yearOrMonth: YearOrMonth.years,
              vaccine: false,
              id: responsePet['petId'],
              name: '',
              description: description,
              createdAt: timeNow,
              category: PetCategory.found,
              state: state,
              city: city,
              petImage: responsePet['petImage'],
              petOwnerName: user.name,
              petOwnerImage: user.profileImage,
              postId: responsePost['postId'],
            ),
          );

          _homePageController.selectedIndex = 0;
          _feedController.addPost(postEntity);
          _adoptionController.addNewPet(postEntity.pet!);
          _userController.addNewPost(postEntity);

          _publicationPageController.reset();
          Get.back();
        }
      } catch (e) {
        Get.snackbar(
          "Erro",
          "Erro ao criar post",
          duration: const Duration(seconds: 2),
          backgroundColor: primary,
          colorText: base,
        );
      }
    } else {
      Get.snackbar(
        "Imagem",
        "Adicione uma imagem para continuar",
        duration: const Duration(seconds: 2),
        backgroundColor: primary,
        colorText: base,
      );
    }
  }

  Future<void> updatePost() async {
    _publicationPageController.loadingPublication = true;
    final String breed = _publicationPageController.breedController.text;
    final String city = _publicationPageController.cityController.text;
    final String state = _publicationPageController.stateController.text;
    final String description =
        _publicationPageController.descriptionController.text.trim();
    final File petImage = _publicationPageController.petImage;
    final PostEntity temp = _publicationPageController.postEntityTemp;

    try {
      await ApiController().updatePost(
        age: null,
        breed: breed,
        city: city,
        createdAt: temp.postedAt,
        description: description,
        id: temp.id,
        petCategory: PetCategory.found,
        petId: temp.pet!.id,
        petImage: petImage,
        petName: '',
        state: state,
        vaccine: false,
        yearOrMonth: YearOrMonth.years,
      );

      _publicationPageController.reset();
      Get.back();
    } catch (e) {
      _publicationPageController.loadingPublication = false;
      Get.snackbar(
        "Erro",
        "Erro ao atualizar post",
        duration: const Duration(seconds: 2),
        backgroundColor: primary,
        colorText: base,
      );
    }
    _publicationPageController.loadingPublication = false;
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
