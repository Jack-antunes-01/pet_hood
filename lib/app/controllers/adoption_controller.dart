import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/core/entities/entities.dart';

class AdoptionController extends GetxController {
  AdoptionController._privateConstructor();
  static final AdoptionController _instance =
      AdoptionController._privateConstructor();
  factory AdoptionController() {
    return _instance;
  }

  TextEditingController breed = TextEditingController();
  TextEditingController dateSearch = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();

  final Rxn<PetCategory> _petCategory = Rxn<PetCategory>();
  PetCategory get petCategory => _petCategory.value!;
  set petCategory(PetCategory category) => _petCategory.value = category;

  final RxList<PetEntity> _petList = RxList<PetEntity>();
  List<PetEntity> get petList => _petList;
  set petList(List<PetEntity> pets) => _petList.value = pets;

  final RxList<PetEntity> _filteredPetList = RxList<PetEntity>();
  List<PetEntity> get filteredPetList => _filteredPetList;
  set filteredPetList(List<PetEntity> pets) => _filteredPetList.value = pets;

  final RxBool _maxPetsReached = RxBool(false);
  bool get maxPetsReached => _maxPetsReached.value;
  set maxPetsReached(bool isMaxPetsReached) =>
      _maxPetsReached.value = isMaxPetsReached;

  final RxInt _page = RxInt(0);
  int get page => _page.value;
  set page(int page) => _page.value = page;

  final RxBool _filterLoading = RxBool(false);
  bool get filterLoading => _filterLoading.value;
  set filterLoading(bool isFilterLoading) =>
      _filterLoading.value = isFilterLoading;

  final RxBool _loadingPets = RxBool(false);
  bool get loadingPets => _loadingPets.value;
  set loadingPets(bool isLoadingPets) => _loadingPets.value = isLoadingPets;

  void addNewPet(PetEntity pet) {
    petList.insert(0, pet);
  }

  void removePet(String petId) {
    petList.removeWhere((element) => element.id == petId);
    _petList.refresh();
  }

  void updatePet(PetEntity pet) {
    int index = petList.indexWhere((p) => p.id == pet.id);
    if (index != -1) {
      petList[index] = pet;
      _petList.refresh();
    }
  }

  void reset() {
    breed.text = "";
    dateSearch.text = "";
    city.text = "";
    state.text = "";
    filteredPetList = [];
    maxPetsReached = false;
    page = 0;
    filterLoading = false;
    loadingPets = false;
  }

  void clear() {
    breed.text = "";
    dateSearch.text = "";
    city.text = "";
    state.text = "";
    petCategory = PetCategory.normal;
    petList = [];
    filteredPetList = [];
    maxPetsReached = false;
    page = 0;
    filterLoading = false;
    loadingPets = false;
  }
}
