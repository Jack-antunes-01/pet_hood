import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/core/entities/entities.dart';

PostEntity emptyEntity = PostEntity(
  id: "",
  userId: "",
  name: "",
  avatar: "",
  username: "",
  isOwner: false,
  postedAt: DateTime.now(),
);

class PublicationPageController extends GetxController {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController petNameController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController dateMissingController = TextEditingController();
  TextEditingController dateFoundController = TextEditingController();

  final RxBool _isChangePublicationTypeEnabled = RxBool(true);
  bool get isChangePublicationTypeEnabled =>
      _isChangePublicationTypeEnabled.value;
  set isChangePublicationTypeEnabled(bool isChangePublicationTypeEnabled) =>
      _isChangePublicationTypeEnabled.value = isChangePublicationTypeEnabled;

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

  final Rx<PostEntity> _postEntityTemp = Rx<PostEntity>(emptyEntity);
  PostEntity get postEntityTemp => _postEntityTemp.value;
  set postEntityTemp(PostEntity post) => _postEntityTemp.value = post;

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
    isChangePublicationTypeEnabled = true;
    postEntityTemp = emptyEntity;
  }

  void updatePost(PostEntity post) {
    // int index = _feedController.listPosts.indexWhere((p) => p.id == post.id);

// PostEntity updatedPost = PostEntity(
//         id: post.id,
//         type: post.pet!.category,
//         name: post.name,
//         avatar: post.avatar,
//         username: post.username,
//         isOwner: post.isOwner,
//         postedAt: post.postedAt,
//         description:
//       );

    // _feedController.listPosts[index] = post;
  }
}
