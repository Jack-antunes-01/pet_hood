import 'dart:io';

import 'package:get/get.dart';
import 'package:pet_hood/core/entities/entities.dart';

class UserController extends GetxController {
  /// Singleton
  UserController._privateConstructor();
  static final UserController _instance = UserController._privateConstructor();
  factory UserController() {
    return _instance;
  }

  /// Profile Image
  final Rx<File> _profileImage = Rx<File>(File(''));
  File get profileImage => _profileImage.value;
  set profileImage(File image) => _profileImage.value = image;

  final RxBool _loadingProfileImage = RxBool(false);
  bool get loadingProfileImage => _loadingProfileImage.value;
  set loadingProfileImage(bool isLoadingProfileImage) =>
      _loadingProfileImage.value = isLoadingProfileImage;

  /// Background Image
  final Rx<File> _backgroundImage = Rx<File>(File(''));
  File get backgroundImage => _backgroundImage.value;
  set backgroundImage(File image) => _backgroundImage.value = image;

  final RxBool _loadingBackgroundImage = RxBool(false);
  bool get loadingBackgroundImage => _loadingBackgroundImage.value;
  set loadingBackgroundImage(bool isLoadingBackgroundImage) =>
      _loadingBackgroundImage.value = isLoadingBackgroundImage;

  /// User entity
  final Rx<UserEntity> _userEntity = Rx<UserEntity>(
    UserEntity(
      id: "",
      email: "",
      name: "",
      userName: "",
      phoneNumber: "",
      profileImage: "",
      backgroundImage: "",
      birthDate: "",
      bio: "",
    ),
  );
  UserEntity get userEntity => _userEntity.value;
  set userEntity(UserEntity entity) {
    _userEntity.value = entity;
    _userEntity.refresh();
  }

  String password = "";

  final RxList<PetEntity> _petList = RxList<PetEntity>();
  List<PetEntity> get petList => _petList;
  set petList(List<PetEntity> pets) => _petList.value = pets;

  addNewPet(PetEntity pet) {
    petList.add(pet);
  }

  final RxList<PetEntity> _adoptionPetList = RxList<PetEntity>();
  List<PetEntity> get adoptionPetList => _adoptionPetList;
  set adoptionPetList(List<PetEntity> pets) => _adoptionPetList.value = pets;

  addNewAdoptionPet(PetEntity pet) {
    adoptionPetList.add(pet);
    _adoptionPetList.refresh();
  }

  final RxList<PostEntity> _postList = RxList<PostEntity>();
  List<PostEntity> get postList => _postList;
  set postList(List<PostEntity> posts) => _postList.value = posts;

  addNewPost(PostEntity post) {
    postList.add(post);
    _postList.refresh();
  }
}
