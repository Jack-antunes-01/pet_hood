import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:pet_hood/app/components/components.dart';

class PublicationPageController extends GetxController {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController petNameController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController dateMissingController = TextEditingController();
  TextEditingController dateFoundController = TextEditingController();

  final RxInt _selectedOption = RxInt(0);
  int get selectedOption => _selectedOption.value;
  set selectedOption(int index) => _selectedOption.value = index;

  final List items = ["", "Meu pet", "Adoção", "Desaparecido", "Encontrado"];

  final Rx<File> _petImage = Rx<File>(File(''));
  File get petImage => _petImage.value;
  set petImage(File image) => _petImage.value = image;

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

  reset() {
    descriptionController.text = "";
    petNameController.text = "";
    breedController.text = "";
    ageController.text = "";
    cityController.text = "";
    stateController.text = "";
    dateMissingController.text = "";
    dateFoundController.text = "";

    selectedOption = 0;
    petImage = File("");
    loadingPublication = false;
    dropdownValue = "Anos";
    radioValue = RadioEnum.unselected;
  }
}
