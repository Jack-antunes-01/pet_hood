import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/custom_input/custom_input.dart';
import 'package:pet_hood/app/controllers/pet_details_controller.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/utils/regex/only_letters.dart';

class CityStatePublication extends StatefulWidget {
  final bool isPublication;
  const CityStatePublication({
    Key? key,
    this.isPublication = true,
  }) : super(key: key);

  @override
  State<CityStatePublication> createState() => _CityStatePublicationState();
}

class _CityStatePublicationState extends State<CityStatePublication> {
  final PublicationPageController _publicationPageController = Get.find();
  final PetDetailsController _petDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: CustomInput(
            placeholderText: "Cidade",
            controller: widget.isPublication
                ? _publicationPageController.cityController
                : _petDetailsController.cityController,
            validator: (state) =>
                state != null && state.length > 2 ? null : "Cidade Inválida",
            maxLength: 30,
            textCapitalization: TextCapitalization.characters,
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: CustomInput(
            placeholderText: "Estado",
            controller: widget.isPublication
                ? _publicationPageController.stateController
                : _petDetailsController.stateController,
            validator: (state) =>
                state != null && state.length == 2 ? null : "Estado Inválido",
            maxLength: 2,
            textCapitalization: TextCapitalization.characters,
            inputFormatters: [
              FilteringTextInputFormatter.allow(onlyLettersSample),
            ],
          ),
        ),
      ],
    );
  }
}
