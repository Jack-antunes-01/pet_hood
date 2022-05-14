import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/components/publication_create/widgets/city_state_publication.dart';
import 'package:pet_hood/app/components/publication_create/widgets/description_create_publication.dart';
import 'package:pet_hood/app/components/publication_create/widgets/name_breed_publication.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/entities.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({Key? key}) : super(key: key);

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final formKey = GlobalKey<FormState>();

  final PublicationPageController _publicationPageController = Get.find();
  final UserController _userController = Get.find();

  goBack() {
    Get.back();
    _publicationPageController.reset();
  }

  validateForm() async {
    final isValid = formKey.currentState!.validate();

    if (isValid &&
        _publicationPageController.radioValue != RadioEnum.unselected) {
      if (_publicationPageController.petImage.path.isNotEmpty) {
        _publicationPageController.loadingPublication = true;
        await Future.delayed(const Duration(seconds: 2), () {});
        final UserEntity user = _userController.userEntity;
        final String petName =
            _publicationPageController.petNameController.text;
        final String breed = _publicationPageController.breedController.text;
        final int? age =
            int.tryParse(_publicationPageController.ageController.text);
        final YearOrMonth yearOrMonth =
            _publicationPageController.dropdownValue == "Anos"
                ? YearOrMonth.years
                : YearOrMonth.months;
        final bool vaccine =
            _publicationPageController.radioValue == RadioEnum.yes
                ? true
                : false;
        final String city = _publicationPageController.cityController.text;
        final String state = _publicationPageController.stateController.text;
        final String description =
            _publicationPageController.descriptionController.text.trim();
        final File petImage = _publicationPageController.petImage;

        final PetEntity petEntity = PetEntity(
          breed: breed,
          userId: "12312",
          age: age,
          yearOrMonth: YearOrMonth.values
              .firstWhere((element) => element == yearOrMonth),
          vaccine: vaccine,
          id: Random().nextInt(9999).toString(),
          name: petName,
          description: description,
          createdAt: DateTime.now(),
          category: PetCategory.adoption,
          petImageFile: petImage,
          state: state,
          city: city,
          petOwnerName: user.name,
          petOwnerImage: user.profileImage,
        );

        _userController.addNewPet(petEntity);

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
        title: "Adicionar pet",
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
        ),
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

    return const CustomText(
      text: "Publicar",
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: base,
    );
  }
}
