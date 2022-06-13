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

class UserController extends GetxController {
  /// Singleton
  UserController._privateConstructor();
  static final UserController _instance = UserController._privateConstructor();
  factory UserController() {
    return _instance;
  }

  final RxBool _loadingProfileImage = RxBool(false);
  bool get loadingProfileImage => _loadingProfileImage.value;
  set loadingProfileImage(bool isLoadingProfileImage) =>
      _loadingProfileImage.value = isLoadingProfileImage;

  final RxBool _loadingBackgroundImage = RxBool(false);
  bool get loadingBackgroundImage => _loadingBackgroundImage.value;
  set loadingBackgroundImage(bool isLoadingBackgroundImage) =>
      _loadingBackgroundImage.value = isLoadingBackgroundImage;

  /// User entity
  final Rx<UserEntity> _userEntity = Rx<UserEntity>(_emptyUserEntity);
  UserEntity get userEntity => _userEntity.value;
  set userEntity(UserEntity entity) {
    _userEntity.value = entity;
    _userEntity.refresh();
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

  void addNewPet(PetEntity pet) {
    petList.add(pet);
    _petList.refresh();
  }

  void removePet(PetEntity pet) {
    petList.removeWhere((p) => p.id == pet.id);
    _petList.refresh();
  }

  void updatePet(PetEntity pet) {
    int index = petList.indexWhere((p) => p.id == pet.id);
    petList[index] = pet;
    _petList.refresh();
  }

  void addNewAdoptionPet(PetEntity pet) {
    adoptionPetList.add(pet);
    _adoptionPetList.refresh();
  }

  void removeAdoptionPet(String petId) {
    adoptionPetList.removeWhere((pet) => pet.id == petId);
    _adoptionPetList.refresh();
  }

  void updateAdoptionPet(PetEntity pet) {
    int index = adoptionPetList.indexWhere((p) => p.id == pet.id);
    adoptionPetList[index] = pet;
    _adoptionPetList.refresh();
  }

  addNewPost(PostEntity post) {
    postList.add(post);
    _postList.refresh();
  }

  removePublication(String postId) {
    postList.removeWhere((post) => post.id == postId);
    _postList.refresh();
  }

  void updatePost(PostEntity post) {
    int index = postList.indexWhere((p) => p.id == post.id);
    postList[index] = post;
    _postList.refresh();
  }

  void updatePostById(String postId, PetEntity pet) {
    int index = postList.indexWhere((p) => p.id == postId);
    PostEntity post = postList.firstWhere((element) => element.id == postId);
    PostEntity newPost = PostEntity(
      id: post.id,
      type: post.type,
      name: post.name,
      avatar: post.avatar,
      username: post.username,
      isOwner: post.isOwner,
      postedAt: post.postedAt,
      postImageFile: post.postImageFile,
      pet: pet,
    );
    postList[index] = newPost;
    _postList.refresh();
  }

  clear() {
    userEntity = _emptyUserEntity;
    petList = [];
    postList = [];
    adoptionPetList = [];
    loadingProfileImage = false;
    loadingBackgroundImage = false;
  }
}
