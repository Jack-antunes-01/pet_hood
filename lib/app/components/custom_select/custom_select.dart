import 'package:flutter/material.dart';
import 'package:pet_hood/app/theme/colors.dart';

class CustomSelect extends StatefulWidget {
  const CustomSelect({Key? key}) : super(key: key);

  @override
  State<CustomSelect> createState() => _CustomSelectState();
}

class _CustomSelectState extends State<CustomSelect> {
  String dropdownValue = 'Anos';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: inputColor),
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: DropdownButton<String>(
            value: dropdownValue,
            style: const TextStyle(color: grey800, fontSize: 15),
            dropdownColor: base,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            underline: const SizedBox.shrink(),
            isExpanded: true,
            items: <String>["Anos", "Meses"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
