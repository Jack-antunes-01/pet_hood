import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/components/publication_create/widgets/description_create_publication.dart';
import 'package:pet_hood/app/controllers/api_controller.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/pages/feed/feed_controller.dart';
import 'package:pet_hood/app/pages/home/home_page_controller.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/entities.dart';

class CreateNormalPublication extends StatefulWidget {
  const CreateNormalPublication({Key? key}) : super(key: key);

  @override
  State<CreateNormalPublication> createState() =>
      _CreateNormalPublicationState();
}

class _CreateNormalPublicationState extends State<CreateNormalPublication> {
  final PublicationPageController _publicationPageController = Get.find();
  final UserController _userController = Get.find();
  final FeedController _feedController = Get.find();
  final HomePageController _homePageController = Get.put(HomePageController());

  validateForm() async {
    if (_publicationPageController.isChangePublicationTypeEnabled) {
      if (_publicationPageController.petImage.path.isNotEmpty) {
        await savePost();
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
      await updatePost();
    }
  }

  @override
  Widget build(BuildContext context) {
    var safePaddingBottom = MediaQuery.of(context).padding.bottom;
    var height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

  Future<void> savePost() async {
    _publicationPageController.loadingPublication = true;
    final UserEntity user = _userController.userEntity;
    final String description =
        _publicationPageController.descriptionController.text.trim();
    final File petImage = _publicationPageController.petImage;

    try {
      final response = await ApiController().savePetNormalPost(
        image: petImage,
        description: description,
      );

      final responsePost = await ApiController().addPost(
        petCategory: PetCategory.normal,
        imageId: response['petImage'],
        petId: response['petId'],
      );

      if (responsePost['postId'] != null) {
        final PostEntity postEntity = PostEntity(
          id: responsePost['postId'],
          userId: _userController.userEntity.id,
          name: user.name,
          avatar: user.profileImage != null ? user.profileImage! : '',
          username: user.userName,
          isOwner: true,
          pet: PetEntity(
            userId: user.id,
            breed: '',
            state: '',
            id: response['petId'],
            category: PetCategory.normal,
            city: '',
            petImage: response['petImage'],
            petOwnerImage: user.profileImage != null ? user.profileImage! : '',
            createdAt: DateTime.now().add(const Duration(hours: 6)),
            petOwnerName: user.name,
            description: description,
          ),
          postedAt: DateTime.now().add(const Duration(hours: 6)),
          qtLikes: 0,
          isLiked: false,
        );

        _homePageController.selectedIndex = 0;
        _userController.addNewPost(postEntity);
        _feedController.addPost(postEntity);

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
  }

  Future<void> updatePost() async {
    _publicationPageController.loadingPublication = true;
    final String description =
        _publicationPageController.descriptionController.text.trim();
    final File petImage = _publicationPageController.petImage;
    final PostEntity temp = _publicationPageController.postEntityTemp;

    try {
      await ApiController().updatePost(
        age: null,
        breed: '',
        city: '',
        createdAt: temp.postedAt,
        description: description,
        id: temp.id,
        petCategory: PetCategory.normal,
        petId: temp.pet!.id,
        petImage: petImage,
        petName: '',
        state: '',
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
}
