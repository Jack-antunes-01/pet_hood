import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/pet_details_controller.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';

Future pickImage({
  required ImageSource source,
  required BuildContext context,
  required bool isPublication,
}) async {
  try {
    Navigator.of(context).pop();
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemporary = File(image.path);

    final bytes = imageTemporary.readAsBytesSync().lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;
    if (mb < 10) {
      if (isPublication) {
        final PublicationPageController _publicationPageController = Get.find();
        _publicationPageController.petImage = imageTemporary;
      } else {
        final PetDetailsController _petDetailsController = Get.find();
        _petDetailsController.petImage = imageTemporary;
      }
    } else {
      Get.snackbar(
        "Imagem muito grande!",
        "Selecione uma imagem menor que 10MB\nTamanho atual: ${mb.round()} MB",
        backgroundColor: primary,
        colorText: base,
      );
    }
  } on PlatformException {
    Get.snackbar(
      "Permissão negada",
      "Nós precisamos de permissão para executar essa tarefa :/",
      backgroundColor: primary,
      colorText: base,
    );
  }
}

openBottomSheetModalImage({
  required BuildContext context,
  bool isPublication = true,
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
              _header(),
              _content(context, isPublication),
            ],
          ),
        ),
      );
    },
  );
}

Widget _header() {
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

Widget _content(BuildContext context, bool isPublication) {
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
            isPublication: isPublication),
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
            isPublication: isPublication),
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
