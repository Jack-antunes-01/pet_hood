import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/components/publication_create/create_adoption_publication.dart';
import 'package:pet_hood/app/components/publication_create/create_found_publication.dart';
import 'package:pet_hood/app/components/publication_create/create_missing_publication.dart';
import 'package:pet_hood/app/components/publication_create/create_normal_publication.dart';
import 'package:pet_hood/app/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';

class PublicationPage extends StatefulWidget {
  const PublicationPage({Key? key}) : super(key: key);

  @override
  State<PublicationPage> createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  final PublicationPageController _publicationPageController = Get.find();

  Future<bool> _onWillPop() async {
    exitPublication() {
      goBack();
      return false;
    }

    return exitPublication();
  }

  goBack() {
    Get.back();
    _publicationPageController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBarHeader(
          appBar: AppBar(),
          title: _publicationPageController.isChangePublicationTypeEnabled
              ? "Criar publicação"
              : "Editar publicação",
          onBackPress: () => goBack(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                ),
                child: Row(
                  children: [
                    const CustomText(
                      text: "Selecione o tipo da publicação",
                      color: grey800,
                      fontSize: 17,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 16,
                        top: 16,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context),
                          );
                        },
                        child: const Icon(
                          Icons.info_outline,
                          color: grey800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 20),
                  child: Obx(
                    () => Row(
                      children: List.generate(
                        _publicationPageController.items.length,
                        (index) => _publicationTypeCard(
                          index: index,
                          text: _publicationPageController.items[index],
                          selected: index ==
                              _publicationPageController.selectedOption,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(),
                  child: _buildContainer(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    switch (_publicationPageController.selectedOption) {
      case 0:
        return _emptyWidget();
      case 1:
        return const CreateNormalPublication();
      case 2:
        return const CreateAdoptionPublication();
      case 3:
        return const CreateMissingPublication();
      case 4:
        return const CreateFoundPublication();
      default:
        return _emptyWidget();
    }
  }

  Widget _emptyWidget() {
    return const SizedBox.shrink();
  }

  selectTypePublication(int index) {
    if (!_publicationPageController.loadingPublication &&
        _publicationPageController.isChangePublicationTypeEnabled) {
      _publicationPageController.selectedOption = index;
    }
  }

  Widget _publicationTypeCard({
    required String text,
    required bool selected,
    required int index,
  }) {
    return index != 0
        ? Padding(
            padding: const EdgeInsets.only(left: 15),
            child: GestureDetector(
              onTap: () => selectTypePublication(index),
              child: Container(
                decoration: BoxDecoration(
                  color: selected ? primary : base,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 2,
                    color: selected
                        ? primary
                        : _publicationPageController
                                .isChangePublicationTypeEnabled
                            ? grey200
                            : grey200,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: CustomText(
                    text: text,
                    color: selected
                        ? base
                        : _publicationPageController
                                .isChangePublicationTypeEnabled
                            ? grey800
                            : grey200,
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              CustomText(
                text: "Observação",
                color: grey800,
                fontWeight: FontWeight.bold,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(
                  Icons.info_outline,
                  color: grey800,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.close,
              size: 28,
              color: primary,
            ),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CustomText(
            text:
                "O tipo da publicação influencia em quais informações devem ser fornecidas e como seu post será exibido no feed para os outros usuários.",
            color: grey800,
          ),
        ],
      ),
    );
  }
}
