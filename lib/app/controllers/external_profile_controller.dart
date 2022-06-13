import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pet_hood/core/entities/entities.dart';

final UserEntity _emptyUserEntity = UserEntity(
  id: "",
  email: "",
  name: "",
  userName: "",
  profileImage: "",
  backgroundImage: "",
  bio: "",
);

class ExternalProfileController extends GetxController {
  ExternalProfileController._privateConstructor();
  static final ExternalProfileController _instance =
      ExternalProfileController._privateConstructor();
  factory ExternalProfileController() {
    return _instance;
  }

  TextEditingController searchController = TextEditingController();

  final RxBool _loadingList = RxBool(false);
  bool get loadingList => _loadingList.value;
  set loadingList(bool isLoadingList) => _loadingList.value = isLoadingList;

  final RxBool _loadingPetList = RxBool(false);
  bool get loadingPetList => _loadingPetList.value;
  set loadingPetList(bool isLoadingPetList) =>
      _loadingPetList.value = isLoadingPetList;

  final Rx<UserEntity> _externalUserEntity = Rx<UserEntity>(_emptyUserEntity);
  UserEntity get externalUserEntity => _externalUserEntity.value;
  set externalUserEntity(UserEntity entity) {
    _externalUserEntity.value = entity;
    _externalUserEntity.refresh();
  }

  final RxList<UserEntity> _userList = RxList<UserEntity>([]);
  List<UserEntity> get userList => _userList;
  set userList(List<UserEntity> entity) {
    _userList.value = entity;
    _userList.refresh();
  }

  final RxList<PetEntity> _petList = RxList<PetEntity>();
  List<PetEntity> get petList => _petList;
  set petList(List<PetEntity> pets) => _petList.value = pets;

  final RxList<PetEntity> _adoptionPetList = RxList<PetEntity>();
  List<PetEntity> get adoptionPetList => _adoptionPetList;
  set adoptionPetList(List<PetEntity> pets) => _adoptionPetList.value = pets;

  final RxList<PostEntity> _postList = RxList<PostEntity>();
  List<PostEntity> get postList => _postList;
  set postList(List<PostEntity> posts) => _postList.value = posts;

  clear() {
    externalUserEntity = _emptyUserEntity;
    petList = [];
    postList = [];
    adoptionPetList = [];
    loadingList = false;
  }
}
