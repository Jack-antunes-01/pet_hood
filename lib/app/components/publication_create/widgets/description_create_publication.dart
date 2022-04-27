import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/bottom_sheet_modal/bottom_sheet_image.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';

class DescriptionCreatePublication extends StatelessWidget {
  DescriptionCreatePublication({Key? key}) : super(key: key);

  final PublicationPageController _publicationPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16, top: 16),
                child: CustomText(text: "Descrição", color: grey800),
              ),
              TextField(
                controller: _publicationPageController.descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: grey200,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    openBottomSheetModalImage(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(Icons.collections_outlined, color: grey800),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        child:
                            CustomText(text: "Anexar imagem", color: grey800),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => _publicationPageController.petImage.path.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SizedBox(
                    height: 250,
                    width: width,
                    child: Image.file(
                      _publicationPageController.petImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
