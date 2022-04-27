import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/custom_input/custom_input.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';

class CityStatePublication extends StatefulWidget {
  const CityStatePublication({Key? key}) : super(key: key);

  @override
  State<CityStatePublication> createState() => _CityStatePublicationState();
}

class _CityStatePublicationState extends State<CityStatePublication> {
  final PublicationPageController _publicationPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: CustomInput(
            placeholderText: "Cidade",
            controller: _publicationPageController.cityController,
            validator: (state) =>
                state != null && state.length > 2 ? null : "Cidade Inválida",
            maxLength: 30,
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: CustomInput(
            placeholderText: "Estado",
            controller: _publicationPageController.stateController,
            validator: (state) =>
                state != null && state.length == 2 ? null : "Estado Inválido",
            maxLength: 2,
          ),
        ),
      ],
    );
  }
}
