import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/core/entities/pet_entity.dart';

PetEntity emptyEntity = PetEntity(
  id: "",
  userId: "",
  breed: "",
  description: "",
  city: "",
  state: "",
  category: PetCategory.adoption,
  createdAt: DateTime.now().add(const Duration(hours: 6)),
  petOwnerName: "",
  petOwnerImage: "",
);

class PetDetailsController extends GetxController {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController petNameController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  final RxBool _isExternalProfile = RxBool(false);
  bool get isExternalProfile => _isExternalProfile.value;
  set isExternalProfile(bool isExternal) =>
      _isExternalProfile.value = isExternal;

  final Rx<PetEntity> _petDetail = Rx<PetEntity>(emptyEntity);
  PetEntity get petDetail => _petDetail.value;
  set petDetail(PetEntity pet) => _petDetail.value = pet;

  final Rx<PetEntity> _petDetailExternal = Rx<PetEntity>(emptyEntity);
  PetEntity get petDetailExternal => _petDetailExternal.value;
  set petDetailExternal(PetEntity pet) => _petDetailExternal.value = pet;

  final RxBool _isOwner = RxBool(false);
  bool get isOwner => _isOwner.value;
  set isOwner(bool isPetOwner) => _isOwner.value = isPetOwner;

  final RxBool _isOwnerExternal = RxBool(false);
  bool get isOwnerExternal => _isOwnerExternal.value;
  set isOwnerExternal(bool isPetOwner) => _isOwnerExternal.value = isPetOwner;

  final RxBool _loadingPublication = RxBool(false);
  bool get loadingPublication => _loadingPublication.value;
  set loadingPublication(bool isLoadingPublication) =>
      _loadingPublication.value = isLoadingPublication;

  final RxString _dropdownValue = RxString("Anos");
  String get dropdownValue => _dropdownValue.value;
  set dropdownValue(String value) => _dropdownValue.value = value;

  final Rx<RadioEnum> _radioValue = Rx<RadioEnum>(RadioEnum.unselected);
  RadioEnum get radioValue => _radioValue.value;
  set radioValue(RadioEnum radioEnum) => _radioValue.value = radioEnum;

  final Rx<File> _petImage = Rx<File>(File(''));
  File get petImage => _petImage.value;
  set petImage(File image) => _petImage.value = image;

  void resetPet({
    required bool isExternalProfile,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    isExternalProfile
        ? petDetailExternal = emptyEntity
        : petDetail = emptyEntity;

    isExternalProfile ? isOwnerExternal = false : isOwner = false;
    this.isExternalProfile = false;
  }

  void setPet({
    required PetEntity pet,
    required String userId,
    required bool isExternalProfile,
  }) {
    this.isExternalProfile = isExternalProfile;
    isExternalProfile
        ? isOwnerExternal = userId == pet.userId
        : isOwner = userId == pet.userId;
    isExternalProfile ? petDetailExternal = pet : petDetail = pet;
  }

  void setFormValues() {
    if (petDetail.id.isNotEmpty) {
      descriptionController.text =
          petDetail.description.isNotEmpty ? petDetail.description : '';
      petNameController.text =
          petDetail.name!.isNotEmpty ? petDetail.name! : '';
      breedController.text =
          petDetail.breed!.isNotEmpty ? petDetail.breed! : '';
      ageController.text =
          petDetail.age != null ? petDetail.age!.toString() : '';
      cityController.text = petDetail.city.isNotEmpty ? petDetail.city : '';
      stateController.text = petDetail.state.isNotEmpty ? petDetail.state : '';

      loadingPublication = false;
      dropdownValue =
          petDetail.yearOrMonth == YearOrMonth.years ? "Anos" : "Meses";
      radioValue = petDetail.vaccine! ? RadioEnum.yes : RadioEnum.no;
    }
  }

  void reset() {
    descriptionController.text = "";
    petNameController.text = "";
    breedController.text = "";
    ageController.text = "";
    cityController.text = "";
    stateController.text = "";

    petImage = File("");
    loadingPublication = false;
    dropdownValue = "Anos";
    radioValue = RadioEnum.unselected;
  }

  void clear() {
    descriptionController.text = "";
    petNameController.text = "";
    breedController.text = "";
    ageController.text = "";
    cityController.text = "";
    stateController.text = "";

    petDetailExternal = emptyEntity;
    petDetail = emptyEntity;
    isExternalProfile = false;
    isOwner = false;
    isOwnerExternal = false;
    petImage = File("");
    loadingPublication = false;
    dropdownValue = "Anos";
    radioValue = RadioEnum.unselected;
  }
}
