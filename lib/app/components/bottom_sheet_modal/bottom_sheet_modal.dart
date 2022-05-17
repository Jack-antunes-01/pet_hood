import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/adoption_controller.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/pages/feed/feed_controller.dart';
import 'package:pet_hood/app/pages/publication/publication_page.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/entities.dart';

void removePetDialog({
  required BuildContext context,
  required PostEntity post,
}) {
  Navigator.of(context).pop();
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
      onPress: () => removePublication(
        post: post,
        context: context,
      ),
      child: const CustomText(text: "Sim", color: base),
    ),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const CustomText(
      text: "Remover publicação",
      color: red,
    ),
    content: const CustomText(
      text: "Você quer remover essa publicação?",
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

Future removePublication({
  required PostEntity post,
  required BuildContext context,
}) async {
  final UserController _userController = Get.find();
  final AdoptionController _adoptionController = Get.find();
  final FeedController _feedController = Get.find();

  if (post.type == PostTypeEnum.adoption) {
    _userController.removeAdoptionPet(post.pet!.id);
  }

  if (post.type == PostTypeEnum.adoption ||
      post.type == PostTypeEnum.disappear ||
      post.type == PostTypeEnum.found) {
    _adoptionController.removePet(post.pet!.id);
  }

  _userController.removePublication(post.id);
  _feedController.removePublication(post.id);

  Navigator.of(context).pop();
}

void editPublication({
  required BuildContext context,
  required PostEntity post,
}) {
  Navigator.of(context).pop();

  final PublicationPageController _publicationPageController = Get.find();
  _publicationPageController.isChangePublicationTypeEnabled = false;
  _publicationPageController.postEntityTemp = post;

  var pet = post.pet!;

  switch (post.type) {
    case PostTypeEnum.adoption:
      _publicationPageController.selectedOption = 2;
      _publicationPageController.petNameController.text = pet.name!;
      _publicationPageController.ageController.text = pet.age.toString();
      _publicationPageController.dropdownValue =
          pet.yearOrMonth == YearOrMonth.years ? "Anos" : "Meses";
      _publicationPageController.radioValue =
          pet.vaccine! ? RadioEnum.yes : RadioEnum.no;
      break;
    case PostTypeEnum.disappear:
      _publicationPageController.selectedOption = 3;
      _publicationPageController.petNameController.text = pet.name!;
      _publicationPageController.ageController.text = pet.age.toString();
      _publicationPageController.dropdownValue =
          pet.yearOrMonth == YearOrMonth.years ? "Anos" : "Meses";
      break;
    case PostTypeEnum.found:
      _publicationPageController.selectedOption = 4;
      break;
    default:
      _publicationPageController.selectedOption = 1;
      break;
  }

  _publicationPageController.petImage = post.postImageFile!;
  _publicationPageController.descriptionController.text =
      post.description ?? "";

  if (post.type != PostTypeEnum.normal) {
    _publicationPageController.breedController.text = pet.breed!;
    _publicationPageController.cityController.text = pet.city;
    _publicationPageController.stateController.text = pet.state;
  }

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
      return const PublicationPage();
    },
  );
}

openBottomSheetModal({
  required BuildContext context,
  required bool owner,
  required PostEntity post,
}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext buildContext) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(buildContext).padding.bottom),
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: CustomText(text: "Opções", color: grey800),
                  ),
                ],
              ),
              const Divider(thickness: 1, color: grey200, height: 0),
              owner
                  ? Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.edit_outlined,
                            color: grey800,
                          ),
                          title: const CustomText(
                              text: 'Editar publicação', color: grey800),
                          onTap: () => editPublication(
                            context: context,
                            post: post,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.delete_forever,
                            color: red,
                          ),
                          title: const CustomText(
                              text: 'Apagar publicação', color: red),
                          onTap: () => removePetDialog(
                            context: context,
                            post: post,
                          ),
                        )
                      ],
                    )
                  : ListTile(
                      leading: const Icon(
                        Icons.report_gmailerrorred_rounded,
                        color: grey800,
                      ),
                      title:
                          const CustomText(text: 'Denunciar', color: grey800),
                      onTap: () {
                        Get.snackbar(
                          "Denúncia",
                          "Denúncia feita com sucesso.",
                          backgroundColor: primary,
                          colorText: base,
                          duration: const Duration(seconds: 2),
                        );
                        Navigator.of(context).pop();
                      },
                    ),
            ],
          ),
        ),
      );
    },
  );
}
