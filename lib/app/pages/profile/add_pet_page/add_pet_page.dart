import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/components/publication_create/widgets/city_state_publication.dart';
import 'package:pet_hood/app/components/publication_create/widgets/description_create_publication.dart';
import 'package:pet_hood/app/components/publication_create/widgets/name_breed_publication.dart';
import 'package:pet_hood/app/controllers/api_controller.dart';
import 'package:pet_hood/app/controllers/pet_details_controller.dart';
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

  final PetDetailsController _petDetailsController = Get.find();

  @override
  void initState() {
    super.initState();

    _petDetailsController.setFormValues();
  }

  void goBack() {
    Get.back();
    _petDetailsController.reset();
  }

  void savePet() async {
    final String breed = _petDetailsController.breedController.text;
    final String petName = _petDetailsController.petNameController.text;
    final int? age = int.tryParse(_petDetailsController.ageController.text);
    final bool vaccine =
        _petDetailsController.radioValue == RadioEnum.yes ? true : false;
    final YearOrMonth yearOrMonth =
        _petDetailsController.dropdownValue == "Anos"
            ? YearOrMonth.years
            : YearOrMonth.months;
    final String description =
        _petDetailsController.descriptionController.text.trim();
    final String state = _petDetailsController.stateController.text;
    final String city = _petDetailsController.cityController.text;
    final File petImage = _petDetailsController.petImage;
    const PetCategory petCategory = PetCategory.profile;

    final response = await ApiController().saveProfilePet(
      breed: breed,
      petName: petName,
      age: age,
      vaccine: vaccine,
      yearOrMonth: yearOrMonth,
      description: description,
      state: state,
      city: city,
      petImage: petImage,
      petCategory: petCategory,
    );

    if (response) {
      goBack();
    }
  }

  void updatePet() async {
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
    const PetCategory petCategory = PetCategory.profile;

    final response = await ApiController().updateProfilePet(
      id: _petDetailsController.petDetail.id,
      breed: breed,
      petName: petName,
      age: age,
      vaccine: vaccine,
      yearOrMonth: yearOrMonth,
      description: description,
      state: state,
      city: city,
      petImage: petImage,
      petCategory: petCategory,
    );

    if (response) {
      goBack();
    }
  }

  void validateForm() async {
    final isValid = formKey.currentState!.validate();

    if (isValid && _petDetailsController.radioValue != RadioEnum.unselected) {
      if (_petDetailsController.petImage.path.isNotEmpty ||
          (_petDetailsController.petDetail.petImage != null &&
              _petDetailsController.petDetail.petImage!.isNotEmpty)) {
        _petDetailsController.loadingPublication = true;

        if (_petDetailsController.petDetail.id.isNotEmpty) {
          updatePet();
        } else {
          savePet();
        }
        _petDetailsController.loadingPublication = false;
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
