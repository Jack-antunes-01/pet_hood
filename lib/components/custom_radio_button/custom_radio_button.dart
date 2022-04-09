import 'package:flutter/material.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/theme/colors.dart';

enum RadioEnum { unselected, yes, no }
List<String> items = ["Sim", "Não"];

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({Key? key}) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  RadioEnum? _radioValue = RadioEnum.unselected;

  setRadioValue(int index) {
    if (index == 0) {
      setState(() => _radioValue = RadioEnum.yes);
    } else {
      setState(() => _radioValue = RadioEnum.no);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Row(
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
                focusColor: Colors.red,
                groupValue: _radioValue,
                onChanged: (RadioEnum? value) {
                  setState(() {
                    _radioValue = value;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
