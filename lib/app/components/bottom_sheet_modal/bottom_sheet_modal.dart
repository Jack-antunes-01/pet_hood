import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/theme/colors.dart';

openBottomSheetModal(BuildContext context, bool owner) {
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
                  ? ListTile(
                      leading: const Icon(
                        Icons.edit_outlined,
                        color: grey800,
                      ),
                      title: const CustomText(text: 'Editar', color: grey800),
                      onTap: () => {},
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
