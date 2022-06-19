import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/components/publication_create/widgets/city_state_publication.dart';
import 'package:pet_hood/app/components/publication_create/widgets/description_create_publication.dart';
import 'package:pet_hood/app/components/publication_create/widgets/name_breed_publication.dart';
import 'package:pet_hood/app/controllers/adoption_controller.dart';
import 'package:pet_hood/app/controllers/api_controller.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/pages/feed/feed_controller.dart';
import 'package:pet_hood/app/pages/home/home_page_controller.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/entities.dart';

class CreateAdoptionPublication extends StatefulWidget {
  const CreateAdoptionPublication({Key? key}) : super(key: key);

  @override
  State<CreateAdoptionPublication> createState() =>
      _CreateAdoptionPublicationState();
}

class _CreateAdoptionPublicationState extends State<CreateAdoptionPublication> {
  final PublicationPageController _publicationPageController = Get.find();
  final UserController _userController = Get.find();
  final FeedController _feedController = Get.find();
  final AdoptionController _adoptionController = Get.find();
  final HomePageController _homePageController = Get.find();

  final formKey = GlobalKey<FormState>();

  validateForm() async {
    final isValid = formKey.currentState!.validate();

    if (isValid &&
        _publicationPageController.radioValue != RadioEnum.unselected) {
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
    _publicationPageController.loadingPublication = false;
  }

  Future savePost() async {
    if (_publicationPageController.petImage.path.isNotEmpty) {
      _publicationPageController.loadingPublication = true;

      final UserEntity user = _userController.userEntity;
      final String petName = _publicationPageController.petNameController.text;
      final String breed = _publicationPageController.breedController.text;
      final int? age =
          int.tryParse(_publicationPageController.ageController.text);
      final YearOrMonth yearOrMonth =
          _publicationPageController.dropdownValue == "Anos"
              ? YearOrMonth.years
              : YearOrMonth.months;
      final bool vaccine =
          _publicationPageController.radioValue == RadioEnum.yes ? true : false;
      final String city = _publicationPageController.cityController.text;
      final String state = _publicationPageController.stateController.text;
      final String description =
          _publicationPageController.descriptionController.text.trim();
      final File petImage = _publicationPageController.petImage;

      final bool isSavingPublication =
          _publicationPageController.isChangePublicationTypeEnabled;

      try {
        final responsePet = await ApiController().savePet(
          breed: breed,
          petName: petName,
          age: age,
          vaccine: vaccine,
          yearOrMonth: yearOrMonth,
          description: description,
          state: state,
          city: city,
          petImage: petImage,
          petCategory: PetCategory.adoption,
        );

        final responsePost = await ApiController().addPost(
          imageId: responsePet['petImage'],
          petId: responsePet['petId'],
          petCategory: PetCategory.adoption,
        );

        if (responsePost['postId'] != null &&
            responsePet['petId'] != null &&
            responsePet['petImage'] != null) {
          final PostEntity temp = _publicationPageController.postEntityTemp;
          final DateTime timeNow = DateTime.now().add(const Duration(hours: 6));
          final PostEntity postEntity = PostEntity(
            id: isSavingPublication ? responsePost['postId'] : temp.id,
            userId: _userController.userEntity.id,
            name: user.name,
            avatar: user.profileImage != null ? user.profileImage! : '',
            username: user.userName,
            isOwner: isSavingPublication ? true : temp.isOwner,
            postedAt: isSavingPublication ? timeNow : temp.postedAt,
            pet: PetEntity(
              userId: _userController.userEntity.id,
              breed: breed,
              age: age,
              yearOrMonth: YearOrMonth.values
                  .firstWhere((element) => element == yearOrMonth),
              vaccine: vaccine,
              id: isSavingPublication ? responsePet['petId'] : temp.pet!.id,
              name: petName,
              description: description,
              createdAt: isSavingPublication ? timeNow : temp.pet!.createdAt,
              category: PetCategory.adoption,
              state: state,
              city: city,
              petImage: responsePet['petImage'],
              petOwnerName: user.name,
              petOwnerImage: user.profileImage,
              postId: isSavingPublication ? responsePost['postId'] : temp.id,
            ),
          );

          if (isSavingPublication) {
            _feedController.addPost(postEntity);
            _userController.addNewPost(postEntity);
            _userController.addNewAdoptionPet(postEntity.pet!);
            _adoptionController.addNewPet(postEntity.pet!);
          } else {
            _feedController.updatePost(postEntity);
            _userController.updatePost(postEntity);
            _userController.updateAdoptionPet(postEntity.pet!);
            _adoptionController.updatePet(postEntity.pet!);
          }

          _homePageController.selectedIndex = 0;

          _publicationPageController.reset();
          Get.back();
        }
      } catch (e) {
        Get.snackbar(
          "Erro",
          "Erro ao adicionar pet",
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

  Future updatePost() async {
    final String petName = _publicationPageController.petNameController.text;
    final String breed = _publicationPageController.breedController.text;
    final int? age =
        int.tryParse(_publicationPageController.ageController.text);
    final YearOrMonth yearOrMonth =
        _publicationPageController.dropdownValue == "Anos"
            ? YearOrMonth.years
            : YearOrMonth.months;
    final bool vaccine =
        _publicationPageController.radioValue == RadioEnum.yes ? true : false;
    final String city = _publicationPageController.cityController.text;
    final String state = _publicationPageController.stateController.text;
    final String description =
        _publicationPageController.descriptionController.text.trim();
    final File petImage = _publicationPageController.petImage;
    final PostEntity temp = _publicationPageController.postEntityTemp;

    try {
      await ApiController().updatePost(
        age: age,
        breed: breed,
        city: city,
        createdAt: temp.postedAt,
        description: description,
        id: temp.id,
        petCategory: PetCategory.adoption,
        petId: temp.pet!.id,
        petImage: petImage,
        petName: petName,
        state: state,
        vaccine: vaccine,
        yearOrMonth: yearOrMonth,
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                NameBreedPublication(),
                CustomText(
                  text: "Seu pet é vacinado?",
                  color: grey800,
                  fontSize: 17,
                ),
                CustomRadioButton(),
                CityStatePublication()
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
