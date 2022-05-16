import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/pet_details_controller.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/utils/regex/only_letters.dart';

class NameBreedPublication extends StatefulWidget {
  final bool isPublication;

  const NameBreedPublication({
    Key? key,
    this.isPublication = true,
  }) : super(key: key);

  @override
  State<NameBreedPublication> createState() => _NameBreedPublicationState();
}

class _NameBreedPublicationState extends State<NameBreedPublication> {
  final PublicationPageController _publicationPageController = Get.find();
  final PetDetailsController _petDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 16),
          child: CustomInput(
            controller: widget.isPublication
                ? _publicationPageController.petNameController
                : _petDetailsController.petNameController,
            placeholderText: "Nome do pet",
            validator: (name) =>
                name != null && name.isNotEmpty ? null : "Digite o nome do pet",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Flexible(
                child: CustomInput(
                  controller: widget.isPublication
                      ? _publicationPageController.breedController
                      : _petDetailsController.breedController,
                  placeholderText: "Raça",
                  validator: (breed) => breed != null && breed.isNotEmpty
                      ? null
                      : "Digite a raça do pet",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(onlyLettersWithBlank),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Flexible(
                child: CustomInput(
                  controller: widget.isPublication
                      ? _publicationPageController.ageController
                      : _petDetailsController.ageController,
                  placeholderText: "Idade",
                  validator: (age) => age != null && age.isNotEmpty
                      ? null
                      : "Digite a idade do pet",
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  maxLength: 2,
                ),
              ),
              const SizedBox(width: 16),
              Obx(
                () => Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: inputColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: DropdownButton<String>(
                        value: widget.isPublication
                            ? _publicationPageController.dropdownValue
                            : _petDetailsController.dropdownValue,
                        style: const TextStyle(color: grey800, fontSize: 15),
                        dropdownColor: base,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            // widget.isPublication
                            //     ? _publicationPageController.dropdownValue =
                            //         newValue
                            //     : _petDetailsController.dropdownValue =
                            //         newValue;
                          }
                        },
                        underline: const SizedBox.shrink(),
                        isExpanded: true,
                        items: ["Anos", "Meses"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: CustomText(
                              text: value,
                              color: grey800,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
