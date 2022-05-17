import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/components/publication_create/widgets/city_state_publication.dart';
import 'package:pet_hood/app/components/publication_create/widgets/description_create_publication.dart';
import 'package:pet_hood/app/components/publication_create/widgets/name_breed_publication.dart';
import 'package:pet_hood/app/controllers/adoption_controller.dart';
import 'package:pet_hood/app/controllers/pet_details_controller.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/pages/feed/feed_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/entities.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final formKey = GlobalKey<FormState>();

  final UserController _userController = Get.find();
  final PetDetailsController _petDetailsController = Get.find();
  final FeedController _feedController = Get.find();
  final AdoptionController _adoptionController = Get.find();

  @override
  void initState() {
    super.initState();

    _petDetailsController.setFormValues();
  }

  void goBack() {
    Get.back();
    _petDetailsController.reset();
  }

  void savePet() {
    final UserEntity user = _userController.userEntity;
    final String petName = _petDetailsController.petNameController.text;
    final String breed = _petDetailsController.breedController.text;
    final int? age = int.tryParse(_petDetailsController.ageController.text);
    final YearOrMonth yearOrMonth =
        _petDetailsController.dropdownValue == "Anos"
            ? YearOrMonth.years
            : YearOrMonth.months;
    final bool vaccine =
        _petDetailsController.radioValue == RadioEnum.yes ? true : false;
    final String city = _petDetailsController.cityController.text;
    final String state = _petDetailsController.stateController.text;
    final String description =
        _petDetailsController.descriptionController.text.trim();
    final File petImage = _petDetailsController.petImage;

    final PetEntity petEntity = PetEntity(
      breed: breed,
      userId: _userController.userEntity.id,
      age: age,
      yearOrMonth:
          YearOrMonth.values.firstWhere((element) => element == yearOrMonth),
      vaccine: vaccine,
      id: Random().nextInt(9999).toString(),
      name: petName,
      description: description,
      createdAt: DateTime.now(),
      category: PetCategory.normal,
      petImageFile: petImage,
      state: state,
      city: city,
      petOwnerName: user.name,
      petOwnerImage: user.profileImage,
    );

    _userController.addNewPet(petEntity);
  }

  void updatePet() {
    final String petName = _petDetailsController.petNameController.text;
    final String breed = _petDetailsController.breedController.text;
    final int? age = int.tryParse(_petDetailsController.ageController.text);
    final YearOrMonth yearOrMonth =
        _petDetailsController.dropdownValue == "Anos"
            ? YearOrMonth.years
            : YearOrMonth.months;
    final bool vaccine =
        _petDetailsController.radioValue == RadioEnum.yes ? true : false;
    final String city = _petDetailsController.cityController.text;
    final String state = _petDetailsController.stateController.text;
    final String description =
        _petDetailsController.descriptionController.text.trim();
    final File petImage = _petDetailsController.petImage;

    final PetEntity petEntity = PetEntity(
      breed: breed,
      userId: _petDetailsController.petDetail.userId,
      age: age,
      yearOrMonth:
          YearOrMonth.values.firstWhere((element) => element == yearOrMonth),
      vaccine: vaccine,
      id: _petDetailsController.petDetail.id,
      name: petName,
      description: description,
      createdAt: _petDetailsController.petDetail.createdAt,
      category: _petDetailsController.petDetail.category,
      petImageFile: petImage,
      state: state,
      city: city,
      petOwnerName: _petDetailsController.petDetail.petOwnerName,
      petOwnerImage: _petDetailsController.petDetail.petOwnerImage,
      postId: _petDetailsController.petDetail.postId,
    );

    _petDetailsController.petDetail = petEntity;

    if (petEntity.category == PetCategory.adoption) {
      _feedController.updatePostById(petEntity.postId!, petEntity);
      _userController.updatePostById(petEntity.postId!, petEntity);
      _userController.updateAdoptionPet(petEntity);
      _adoptionController.updatePet(petEntity);
    } else {
      _userController.updatePet(petEntity);
    }
  }

  void validateForm() async {
    final isValid = formKey.currentState!.validate();

    if (isValid && _petDetailsController.radioValue != RadioEnum.unselected) {
      if (_petDetailsController.petImage.path.isNotEmpty) {
        _petDetailsController.loadingPublication = true;
        await Future.delayed(const Duration(seconds: 2), () {});

        if (_petDetailsController.petDetail.id.isNotEmpty) {
          updatePet();
        } else {
          savePet();
        }

        goBack();
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

  @override
  Widget build(BuildContext context) {
    var safePaddingBottom = MediaQuery.of(context).padding.bottom;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBarHeader(
        appBar: AppBar(),
        title: _petDetailsController.petDetail.id.isNotEmpty
            ? "Editar pet"
            : "Adicionar pet",
        onBackPress: () => goBack(),
      ),
      body: SingleChildScrollView(
        child: Form(
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
                    NameBreedPublication(
                      isPublication: false,
                    ),
                    CustomText(
                      text: "Seu pet é vacinado?",
                      color: grey800,
                      fontSize: 17,
                    ),
                    CustomRadioButton(
                      isPublication: false,
                    ),
                    CityStatePublication(
                      isPublication: false,
                    ),
                  ],
                ),
              ),
              DescriptionCreatePublication(
                isPublication: false,
              ),
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
        ),
      ),
    );
  }

  Widget _buildButtonOrLoading() {
    if (_petDetailsController.loadingPublication) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: base,
        ),
      );
    }

    return CustomText(
      text:
          _petDetailsController.petDetail.id.isNotEmpty ? "Salvar" : "Publicar",
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: base,
    );
  }
}
