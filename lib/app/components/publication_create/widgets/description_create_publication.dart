import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/bottom_sheet_modal/bottom_sheet_image.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/pet_details_controller.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';

class DescriptionCreatePublication extends StatelessWidget {
  final bool isPublication;

  DescriptionCreatePublication({
    Key? key,
    this.isPublication = true,
  }) : super(key: key);

  final PublicationPageController _publicationPageController = Get.find();
  final PetDetailsController _petDetailsController = Get.find();

  bool haveImage() {
    if (isPublication && _publicationPageController.petImage.path.isNotEmpty) {
      return true;
    }

    if (_petDetailsController.petImage.path.isNotEmpty ||
        (_petDetailsController.petDetail.petImage != null &&
            _petDetailsController.petDetail.petImage!.isNotEmpty)) return true;

    return false;
  }

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
                controller: isPublication
                    ? _publicationPageController.descriptionController
                    : _petDetailsController.descriptionController,
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
                    openBottomSheetModalImage(
                      context: context,
                      isPublication: isPublication,
                    );
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
          () => haveImage()
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SizedBox(
                    height: 250,
                    width: width,
                    child: _petDetailsController.petDetail.id.isNotEmpty &&
                            _petDetailsController.petImage.path.isEmpty
                        // TODO: fix publication type
                        ? Image.network(
                            isPublication
                                ? '${dotenv.env['API_IMAGE']}${_petDetailsController.petDetail.petImage}'
                                : '${dotenv.env['API_IMAGE']}${_petDetailsController.petDetail.petImage}',
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            isPublication
                                ? _publicationPageController.petImage
                                : _petDetailsController.petImage,
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
