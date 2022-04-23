import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/constants/constants.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/data/data.dart';
import 'package:pet_hood/core/entities/pet_entity.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/utils/utils.dart';

class ProfilePage extends StatefulWidget {
  final bool isOwner;

  const ProfilePage({
    Key? key,
    required this.isOwner,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<PetEntity> pets = getPetList();

  final UserController _userController = Get.put(UserController());

  Future pickImage({
    required ImageSource source,
    required BuildContext context,
    required bool isProfileImage,
  }) async {
    try {
      Navigator.of(context).pop();
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);

      if (isProfileImage) {
        _userController.profileImage = imageTemporary;
      } else {
        _userController.backgroundImage = imageTemporary;
      }
    } on PlatformException {
      Get.snackbar(
        "Permissão negada",
        "Nós precisamos de permissão para executar essa tarefa :/",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.bottom;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: safePadding + 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context),
            _bio(),
            _myPets(),
            _adoption(),
            _publications(),
          ],
        ),
      ),
    );
  }

  Widget _publications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Divider(color: grey200, thickness: 10),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
          ),
          child: CustomText(
            text: "Publicações",
            color: grey800,
            fontSize: 18,
          ),
        ),
        // NormalPublication(),
        // Divider(color: grey200, thickness: 10),
        // NormalPublication(),
        // Divider(color: grey200, thickness: 10),
        // NormalPublication(),
      ],
    );
  }

  Widget _adoption() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8, left: 20, right: 20),
          child: CustomText(
            text: "Adoção",
            color: grey800,
            fontSize: 18,
          ),
        ),
        _noAdoptionPets(),
        SizedBox(
          height: 280,
          child: ListView(
            padding: const EdgeInsets.only(left: 20, right: 4),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: getPetList()
                .where((element) => element.category == PetCategory.adoption)
                .map((item) {
              return PetWidget(pet: item, index: 1);
            }).toList(),
          ),
        ),
        widget.isOwner
            ? Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                  right: 20,
                  left: 20,
                ),
                child: CustomButton(
                    text: "Cadastrar pet para adoção", onPress: () {}),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _myPets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8, left: 20, right: 20),
          child: CustomText(
            text: "Meus Pets",
            color: grey800,
            fontSize: 18,
          ),
        ),
        _noPets(),
        SizedBox(
          height: 280,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: buildNewestPet(),
          ),
        ),
        widget.isOwner
            ? Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  bottom: 16,
                ),
                child: CustomButton(text: "Adicionar pet", onPress: () {}),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  List<Widget> buildNewestPet() {
    List<Widget> list = [];

    for (var i = 0; i < pets.length; i++) {
      if (pets[i].createdAt.verifyNewest()) {
        list.add(
          PetWidgetProfile(
            pet: pets[i],
            index: i,
          ),
        );
      }
    }

    return list;
  }

  Widget _noPets() {
    return const Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 16,
      ),
      child: CustomText(
        text:
            "Você não adicionou nenhum pet. Adicione e mostre para todos que acessarem seu perfil!",
        color: grey600,
      ),
    );
  }

  Widget _noAdoptionPets() {
    return const Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 16,
      ),
      child: CustomText(
        text: "Você não possui nenhum pet para adoção.",
        color: grey600,
      ),
    );
  }

  Widget _bio() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: const ListTileTheme(
              contentPadding: EdgeInsets.zero,
              dense: true,
              horizontalTitleGap: 0.0,
              minLeadingWidth: 0,
              child: ExpansionTile(
                initiallyExpanded: true,
                tilePadding: EdgeInsets.only(right: 20, left: 20),
                childrenPadding:
                    EdgeInsets.only(right: 20, left: 20, bottom: 10),
                title: CustomText(
                  text: "Bio",
                  color: grey800,
                  fontSize: 18,
                ),
                children: [
                  CustomText(
                    text:
                        "Um dos fundadores da $appTitle, apaixonado por animais!",
                    color: grey600,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Stack(
            children: [
              Obx(
                () => UserBackgroundImage(
                  backgroundImage: _userController.backgroundImage,
                ),
              ),
              widget.isOwner
                  ? Positioned(
                      right: 10,
                      top: 10,
                      child: Material(
                        color: primary,
                        borderRadius: BorderRadius.circular(4),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () => openBottomSheetModalImage(
                            context: context,
                            isProfileImage: false,
                          ),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child:
                                const Icon(Icons.edit, color: base, size: 18),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 10,
            left: 15,
            child: Row(
              children: [
                Stack(
                  children: [
                    Obx(
                      () => UserAvatar(
                        size: 100,
                        avatar: _userController.profileImage,
                      ),
                    ),
                    widget.isOwner
                        ? Positioned(
                            bottom: 0,
                            right: 0,
                            child: Material(
                              borderRadius: BorderRadius.circular(16),
                              color: primary,
                              child: InkWell(
                                onTap: () => openBottomSheetModalImage(
                                  context: context,
                                  isProfileImage: true,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: base,
                                      width: 1,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: base,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          CustomText(
                            text: "Jackson Antunes",
                            color: grey800,
                            fontSize: 18,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          CustomText(
                            text: "@Jack_antunes01",
                            color: grey600,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                widget.isOwner
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Material(
                          color: primary,
                          borderRadius: BorderRadius.circular(4),
                          child: InkWell(
                            onTap: () => Get.toNamed(Routes.editProfile),
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(
                                Icons.edit_note,
                                color: base,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              CustomText(
                text: "Sobre o usuário",
                color: grey800,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.close,
              size: 28,
              color: primary,
            ),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SelectableText(
            "Jackson Antunes Batista",
            style: TextStyle(
              color: grey800,
            ),
          ),
          SizedBox(height: 10),
          SelectableText(
            "@Jack_antunes01",
            style: TextStyle(
              color: grey800,
            ),
          ),
        ],
      ),
    );
  }

  openBottomSheetModalImage({
    required BuildContext context,
    required bool isProfileImage,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(buildContext).padding.bottom,
          ),
          child: Theme(
            data: ThemeData(
              splashColor: grey200,
              highlightColor: grey200,
            ),
            child: Wrap(
              children: [
                _headerModal(),
                _contentModal(
                  context: context,
                  isProfileImage: isProfileImage,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _headerModal() {
    return Column(
      children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: CustomText(
                text: "Selecione",
                color: grey800,
              ),
            ),
          ],
        ),
        const Divider(thickness: 1, color: grey200, height: 0),
      ],
    );
  }

  Widget _contentModal({
    required BuildContext context,
    required bool isProfileImage,
  }) {
    return Column(
      children: [
        _buildButton(
          icon: const Icon(
            Icons.photo_camera_outlined,
            color: grey800,
          ),
          text: "Tirar foto",
          onTap: () => pickImage(
            source: ImageSource.camera,
            context: context,
            isProfileImage: isProfileImage,
          ),
        ),
        _buildButton(
          icon: const Icon(
            Icons.collections_outlined,
            color: grey800,
          ),
          text: "Galeria",
          onTap: () => pickImage(
            source: ImageSource.gallery,
            context: context,
            isProfileImage: isProfileImage,
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required Icon icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: icon,
      title: CustomText(text: text, color: grey800),
      onTap: onTap,
    );
  }
}
