import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/utils/regex/only_letters.dart';

class NameBreedPublication extends StatefulWidget {
  const NameBreedPublication({Key? key}) : super(key: key);

  @override
  State<NameBreedPublication> createState() => _NameBreedPublicationState();
}

class _NameBreedPublicationState extends State<NameBreedPublication> {
  final PublicationPageController _publicationPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 16),
          child: CustomInput(
            controller: _publicationPageController.petNameController,
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
                  controller: _publicationPageController.breedController,
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
                  controller: _publicationPageController.ageController,
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
                        value: _publicationPageController.dropdownValue,
                        style: const TextStyle(color: grey800, fontSize: 15),
                        dropdownColor: base,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            _publicationPageController.dropdownValue = newValue;
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
