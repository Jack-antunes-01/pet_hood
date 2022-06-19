import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/pet_details_controller.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';

enum RadioEnum { unselected, yes, no }
List<String> items = ["Sim", "Não"];

class CustomRadioButton extends StatefulWidget {
  final bool isPublication;

  const CustomRadioButton({
    Key? key,
    this.isPublication = true,
  }) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  final PublicationPageController _publicationPageController = Get.find();
  final PetDetailsController _petDetailsController = Get.find();

  setRadioValue(int index) {
    if (index == 0) {
      if (widget.isPublication) {
        _petDetailsController.radioValue = RadioEnum.yes;
      } else {
        _publicationPageController.radioValue = RadioEnum.yes;
      }
    } else {
      if (widget.isPublication) {
        _petDetailsController.radioValue = RadioEnum.no;
      } else {
        _publicationPageController.radioValue = RadioEnum.no;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Obx(
        () => Row(
          children: List.generate(
            items.length,
            (index) => Flexible(
              child: ListTile(
                dense: true,
                horizontalTitleGap: 0,
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  setRadioValue(index);
                },
                title: CustomText(
                  text: items[index],
                  color: grey800,
                  fontSize: 16,
                ),
                leading: Radio<RadioEnum>(
                  value: index == 0 ? RadioEnum.yes : RadioEnum.no,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(horizontal: -4),
                  activeColor: primary,
                  focusColor: red,
                  groupValue: widget.isPublication
                      ? _publicationPageController.radioValue
                      : _petDetailsController.radioValue,
                  onChanged: (RadioEnum? value) {
                    widget.isPublication
                        ? _publicationPageController.radioValue = value!
                        : _petDetailsController.radioValue = value!;
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
