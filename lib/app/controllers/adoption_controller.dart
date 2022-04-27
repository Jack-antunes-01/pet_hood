import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/data/data.dart';
import 'package:pet_hood/core/entities/entities.dart';

class AdoptionController extends GetxController {
  TextEditingController breed = TextEditingController();
  TextEditingController dateSearch = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();

  final Rxn<PetCategory> _petCategory = Rxn<PetCategory>();
  PetCategory get petCategory => _petCategory.value!;
  set petCategory(PetCategory category) => _petCategory.value = category;

  final RxList<PetEntity> _petList = RxList<PetEntity>(getPetList());
  List<PetEntity> get petList => _petList;
  set petList(List<PetEntity> pets) => _petList.value = pets;

  addNewAdoptionPet(PetEntity pet) {
    petList.insert(0, pet);
  }

  final RxList<PetEntity> _filteredPetList = RxList<PetEntity>();
  List<PetEntity> get filteredPetList => _filteredPetList;
  set filteredPetList(List<PetEntity> pets) => _filteredPetList.value = pets;

  final RxBool _filterLoading = RxBool(false);
  bool get filterLoading => _filterLoading.value;
  set filterLoading(bool isFilterLoading) =>
      _filterLoading.value = isFilterLoading;
}
