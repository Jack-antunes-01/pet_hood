import 'package:flutter/material.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/theme/colors.dart';

openBottomSheetModalImage(context) {
  var height = MediaQuery.of(context).size.height;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext buildContext) {
      return Padding(
        padding: EdgeInsets.only(bottom: height * 0.05),
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
                    child: CustomText(
                      text: "Selecione",
                      color: grey800,
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1, color: grey200, height: 0),
              ListTile(
                leading: const Icon(
                  Icons.photo_camera_outlined,
                  color: grey800,
                ),
                title: const CustomText(text: 'Tirar foto', color: grey800),
                onTap: () => {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.collections_outlined,
                  color: grey800,
                ),
                title: const CustomText(text: 'Galeria', color: grey800),
                onTap: () => {},
              ),
            ],
          ),
        ),
      );
    },
  );
}
