import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/components/publication_create/widgets/description_create_publication.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/pages/feed/feed_controller.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/entities.dart';

class CreateNormalPublication extends StatefulWidget {
  const CreateNormalPublication({Key? key}) : super(key: key);

  @override
  State<CreateNormalPublication> createState() =>
      _CreateNormalPublicationState();
}

class _CreateNormalPublicationState extends State<CreateNormalPublication> {
  final PublicationPageController _publicationPageController = Get.find();
  final UserController _userController = Get.find();
  final FeedController _feedController = Get.find();

  validateForm() async {
    if (_publicationPageController.petImage.path.isNotEmpty) {
      _publicationPageController.loadingPublication = true;
      await Future.delayed(const Duration(seconds: 2), () {});
      final UserEntity user = _userController.userEntity;
      final String description =
          _publicationPageController.descriptionController.text.trim();
      final File petImage = _publicationPageController.petImage;

      final PostEntity postEntity = PostEntity(
        type: PostTypeEnum.normal,
        name: user.name,
        avatar: user.profileImage,
        username: user.userName,
        isOwner: true,
        postImageFile: petImage,
        description: description,
        postedAt: DateTime.now(),
        qtLikes: 0,
        isLiked: false,
      );

      _feedController.addPost(postEntity);

      _publicationPageController.reset();
      Get.back();
    } else {
      Get.snackbar(
        "Imagem",
        "Adicione uma imagem para continuar",
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
