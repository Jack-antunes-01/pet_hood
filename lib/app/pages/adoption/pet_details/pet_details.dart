import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/components/expandable_text/expandable_text.dart';
import 'package:pet_hood/app/components/pinch_to_zoom/pinch_to_zoom.dart';
import 'package:pet_hood/app/controllers/api_controller.dart';
import 'package:pet_hood/app/controllers/pet_details_controller.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/pages/profile/add_pet_page/add_pet_page.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/entities.dart';
import 'package:pet_hood/utils/utils.dart';

class PetDetails extends StatelessWidget {
  final UserController _userController = Get.find();
  final PetDetailsController _petDetailsController = Get.find();
  // static late bool test;
  PetDetails({
    Key? key,
  }) : super(key: key);

  void openExternalProfile() async {
    if (_petDetailsController.isExternalProfile) {
      goBack();
    } else {
      await ApiController().goToExternalProfileById(
        userId: _petDetailsController.petDetail.userId,
        goToMyProfile: true,
      );
    }
  }

  void goBack() {
    Get.back();
    _petDetailsController.resetPet(
        isExternalProfile: _petDetailsController.isExternalProfile);
  }

  void removePet(BuildContext context) async {
    final response =
        await ApiController().removePet(_petDetailsController.petDetail.id);
    if (response) {
      Navigator.of(context).pop();
      Get.back();
    }
  }

  void openEditMenu({required BuildContext context}) {
    Navigator.of(context).pop();

    showGeneralDialog(
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
      context: context,
      barrierColor: base, // Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return const AddPetPage();
      },
    );
  }

  void removePetDialog(BuildContext context) {
    Navigator.of(context).pop();
    // set up the buttons
    Widget cancelButton = Flexible(
      child: CustomButton(
        backgroundColor: base,
        onPress: () {
          Navigator.of(context).pop();
        },
        child: const CustomText(text: "Não", color: grey800),
      ),
    );
    Widget continueButton = Flexible(
      child: CustomButton(
        backgroundColor: red,
        onPress: () => removePet(context),
        child: const CustomText(text: "Sim", color: base),
      ),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const CustomText(
        text: "Remover pet",
        color: red,
      ),
      content: const CustomText(
        text: "Você quer remover esse pet?",
        color: grey800,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: Row(
            children: [
              cancelButton,
              const SizedBox(
                width: 8,
              ),
              continueButton,
            ],
          ),
        )
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(context),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _petImage(context),
                  Expanded(
                    child: Container(
                      color: base,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => _header()),
                          Obx(() => _content()),
                          const Spacer(),
                          _footer(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => goBack(),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: base,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: grey800,
                  ),
                ),
              ),
            ),
          ),
          !_petDetailsController.isExternalProfile &&
                  _petDetailsController.isOwner &&
                  _petDetailsController.petDetail.category.name == "profile"
              ? GestureDetector(
                  onTap: () => openBottomSheetModalEditOrRemove(
                    context: context,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: base,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.more_horiz,
                          color: grey800,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _petImage(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Obx(
          () => Hero(
            tag: _petDetailsController.isExternalProfile
                ? 'p${_petDetailsController.petDetailExternal.petImage!}'
                : _petDetailsController.petDetail.petImage!,
            child: PinchToZoom(
              child: SizedBox(
                height: height * 0.5,
                width: width,
                child: Image.network(
                  '${dotenv.env["API_IMAGE"]}${_petDetailsController.isExternalProfile ? _petDetailsController.petDetailExternal.petImage : _petDetailsController.petDetail.petImage}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String renderPetName() {
    if (_petDetailsController.isExternalProfile &&
        _petDetailsController.petDetailExternal.name!.isNotEmpty) {
      return _petDetailsController.petDetailExternal.name!;
    } else if (_petDetailsController.petDetail.name!.isNotEmpty) {
      return _petDetailsController.petDetail.name!;
    }
    return getPetNameWhenEmpty(
      isExternalProfile: _petDetailsController.isExternalProfile,
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        left: 20,
        top: 16,
        bottom: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                renderPetName(),
                style: const TextStyle(
                  color: grey800,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: grey600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${_petDetailsController.petDetail.city} / ${_petDetailsController.petDetail.state}",
                    style: const TextStyle(
                      color: grey600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          !_petDetailsController.isExternalProfile ||
                  _petDetailsController.isOwner ||
                  _petDetailsController.petDetail.category !=
                      PetCategory.adoption
              ? const SizedBox.shrink()
              : Material(
                  color: primary,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.chatPeople),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: primary.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 0),
                          )
                        ],
                      ),
                      child: const CustomText(
                        text: "Me adote",
                        color: base,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  String getPetNameWhenEmpty({
    required bool isExternalProfile,
  }) {
    final PetCategory category = isExternalProfile
        ? _petDetailsController.petDetailExternal.category
        : _petDetailsController.petDetail.category;
    switch (category) {
      case PetCategory.adoption:
        return "Pet para adoção";
      case PetCategory.disappear:
        return "Pet desaparecido";
      case PetCategory.found:
        return "Pet encontrado";
      default:
        return "Meu nome está vazio :(";
    }
  }

  parseYearOrMonth({
    required int age,
    required bool isExternalProfile,
  }) {
    YearOrMonth yearOrMonth = isExternalProfile
        ? _petDetailsController.petDetailExternal.yearOrMonth!
        : _petDetailsController.petDetail.yearOrMonth!;
    if (age == 1 && yearOrMonth == YearOrMonth.years) {
      return "ano";
    }
    if (age > 1 && yearOrMonth == YearOrMonth.years) {
      return "anos";
    }
    if (age == 1 && yearOrMonth == YearOrMonth.months) {
      return "mês";
    }
    return "meses";
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 12),
              renderFeatures(),
              const SizedBox(width: 12),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            right: 20,
            left: 20,
            top: 16,
            bottom: 8,
          ),
          child: CustomText(
            text: "Descrição",
            color: grey800,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ExpandableText(
            text: renderDescription(),
          ),
        )
      ],
    );
  }

  String renderDescription() {
    if (_petDetailsController.isExternalProfile &&
        _petDetailsController.petDetailExternal.description.isNotEmpty) {
      return _petDetailsController.petDetailExternal.description;
    } else if (_petDetailsController.petDetail.description.isNotEmpty) {
      return _petDetailsController.petDetail.description;
    }
    return "Não há informações adicionais sobre esse pet.";
  }

  Widget renderFeatures() {
    if (_petDetailsController.isExternalProfile) {
      return Row(
        children: [
          _petDetailsController.petDetailExternal.age != null
              ? BuildPetFeature(
                  value:
                      '${_petDetailsController.petDetailExternal.age.toString()} ${parseYearOrMonth(age: _petDetailsController.petDetailExternal.age!, isExternalProfile: _petDetailsController.isExternalProfile)}',
                  feature: "Idade",
                )
              : const SizedBox.shrink(),
          BuildPetFeature(
            value: _petDetailsController.petDetailExternal.breed!,
            feature: "Raça",
          ),
          _petDetailsController.petDetailExternal.vaccine != null
              ? BuildPetFeature(
                  value:
                      _petDetailsController.petDetailExternal.vaccine!.toText(),
                  feature: "Vacinado",
                )
              : const SizedBox.shrink()
        ],
      );
    } else {
      return Row(
        children: [
          _petDetailsController.petDetail.age != null
              ? BuildPetFeature(
                  value:
                      '${_petDetailsController.petDetail.age.toString()} ${parseYearOrMonth(age: _petDetailsController.petDetail.age!, isExternalProfile: _petDetailsController.isExternalProfile)}',
                  feature: "Idade",
                )
              : const SizedBox.shrink(),
          BuildPetFeature(
            value: _petDetailsController.petDetail.breed!,
            feature: "Raça",
          ),
          _petDetailsController.petDetail.vaccine != null
              ? BuildPetFeature(
                  value: _petDetailsController.petDetail.vaccine!.toText(),
                  feature: "Vacinado",
                )
              : const SizedBox.shrink()
        ],
      );
    }
  }

  String renderUserImage() {
    if (_petDetailsController.isExternalProfile) {
      return _petDetailsController.petDetailExternal.petOwnerImage!;
    } else {
      return _petDetailsController.isOwner
          ? _userController.userEntity.profileImage!
          : _petDetailsController.petDetail.petOwnerImage!;
    }
  }

  Widget _footer(context) {
    var safePadding = MediaQuery.of(context).padding.bottom;
    return Padding(
      padding: EdgeInsets.only(
        right: 20,
        left: 20,
        top: 16,
        bottom: safePadding + 10,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => openExternalProfile(),
            child: UserAvatar(
              avatar: renderUserImage(),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: "Publicação feita por",
                color: grey800,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: _petDetailsController.isExternalProfile
                    ? _petDetailsController.petDetailExternal.petOwnerName
                    : _petDetailsController.petDetail.petOwnerName,
                color: grey600,
              ),
            ],
          ),
        ],
      ),
    );
  }

  openBottomSheetModalEditOrRemove({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(buildContext).padding.bottom),
          child: Theme(
            data: ThemeData(
              splashColor: grey200,
              highlightColor: grey200,
            ),
            child: Wrap(
              children: [
                Row(
                  children: const [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: CustomText(text: "Opções", color: grey800),
                    ),
                  ],
                ),
                const Divider(thickness: 1, color: grey200, height: 0),
                ListTile(
                  leading: const Icon(
                    Icons.edit_outlined,
                    color: grey800,
                  ),
                  title: const CustomText(text: 'Editar', color: grey800),
                  onTap: () => openEditMenu(
                    context: context,
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.delete_forever,
                    color: red,
                  ),
                  title: const CustomText(text: 'Remover', color: red),
                  onTap: () => removePetDialog(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
