import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/components/custom_radio_button/custom_radio_button.dart';
import 'package:pet_hood/components/custom_select/custom_select.dart';
import 'package:pet_hood/pages/publication/publication_page_controller.dart';
import 'package:pet_hood/pages/register/first_register_form/fisrt_register_form_controller.dart';
import 'package:pet_hood/theme/colors.dart';

class PublicationPage extends StatelessWidget {
  PublicationPage({Key? key}) : super(key: key);

  final PublicationPageController _publicationPageController = Get.put(
    PublicationPageController(),
  );

  final FirstRegisterFormController _firstRegisterFormController =
      Get.put(FirstRegisterFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        appBar: AppBar(),
        title: "Criar publicação",
        onBackPress: () {
          Get.back();
          _publicationPageController.selectedOption = 0;
        },
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
                        selected:
                            index == _publicationPageController.selectedOption,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(() => Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: _buildContainer(context),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    switch (_publicationPageController.selectedOption) {
      case 0:
        return _emptyWidget();
      case 1:
        return _normalPublication(context);
      case 2:
        return _adoptionPublication(context);
      case 3:
        return _missingPublication(context);
      case 4:
        return _foundPublication(context);
      default:
        return _emptyWidget();
    }
  }

  Widget _foundPublication(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: CustomText(
              text: "Data que o pet foi encontrado:", color: grey800),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 16,
          ),
          child: Row(children: [
            Flexible(
              child: CustomInput(
                controller: _firstRegisterFormController.dateController,
                placeholderText: "01/01/2022",
                readOnly: true,
                suffixIconReverse: const Icon(
                  Icons.calendar_month_outlined,
                  color: primary,
                ),
                onIconPress: () async =>
                    await _firstRegisterFormController.selectDate(),
                labelActive: false,
              ),
            ),
            const SizedBox(width: 16),
            const Flexible(child: CustomInput(placeholderText: "Raça")),
          ]),
        ),
        Row(
          children: const [
            Flexible(child: CustomInput(placeholderText: "Cidade/Estado")),
            SizedBox(width: 16),
            Flexible(child: CustomInput(placeholderText: "Bairro")),
          ],
        ),
        _normalPublication(context),
      ],
    );
  }

  Widget _missingPublication(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16, top: 16),
          child: CustomInput(placeholderText: "Nome do pet"),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: const [
              Flexible(child: CustomInput(placeholderText: "Raça")),
              SizedBox(width: 16),
              Flexible(child: CustomInput(placeholderText: "Idade")),
              SizedBox(width: 16),
              CustomSelect(),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child:
              CustomText(text: "Data que o pet desapareceu: ", color: grey800),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(children: [
            Flexible(
              child: CustomInput(
                controller: _firstRegisterFormController.dateController,
                placeholderText: "01/01/2022",
                readOnly: true,
                suffixIconReverse: const Icon(
                  Icons.calendar_month_outlined,
                  color: primary,
                ),
                onIconPress: () async =>
                    await _firstRegisterFormController.selectDate(),
                labelActive: false,
              ),
            ),
            const Spacer(),
          ]),
        ),
        const CustomText(
          text: "Seu pet possui problemas de saúde?",
          color: grey800,
          fontSize: 17,
        ),
        const CustomRadioButton(),
        Row(
          children: const [
            Flexible(child: CustomInput(placeholderText: "Cidade/Estado")),
            SizedBox(width: 16),
            Flexible(child: CustomInput(placeholderText: "Bairro")),
          ],
        ),
        _normalPublication(context),
      ],
    );
  }

  Widget _adoptionPublication(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16, top: 16),
          child: CustomInput(placeholderText: "Nome do pet"),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: const [
              Flexible(child: CustomInput(placeholderText: "Raça")),
              SizedBox(width: 16),
              Flexible(child: CustomInput(placeholderText: "Idade")),
              SizedBox(width: 16),
              CustomSelect(),
            ],
          ),
        ),
        const CustomText(
          text: "Seu pet é vacinado?",
          color: grey800,
          fontSize: 17,
        ),
        const CustomRadioButton(),
        const CustomText(
          text: "Seu pet possui problemas de saúde?",
          color: grey800,
          fontSize: 17,
        ),
        const CustomRadioButton(),
        Row(
          children: const [
            Flexible(child: CustomInput(placeholderText: "Cidade/Estado")),
            SizedBox(width: 16),
            Flexible(child: CustomInput(placeholderText: "Bairro")),
          ],
        ),
        _normalPublication(context),
      ],
    );
  }

  Widget _normalPublication(BuildContext context) {
    var safePaddingBottom = MediaQuery.of(context).padding.bottom;
    var height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16, top: 16),
          child: CustomText(text: "Descrição", color: grey800),
        ),
        TextField(
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
              _openBottomSheetModal(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(Icons.collections_outlined, color: grey800),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: CustomText(text: "Anexar imagem", color: grey800),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: safePaddingBottom + height * 0.05),
          child: CustomButton(
            text: "Publicar",
            onPress: () {
              Get.back();
              _publicationPageController.selectedOption = 0;
            },
          ),
        ),
      ],
    );
  }

  _openBottomSheetModal(context) {
    var safePadding = MediaQuery.of(context).padding.bottom;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Padding(
            padding: EdgeInsets.only(bottom: safePadding),
            child: Wrap(
              children: [
                Row(
                  children: const [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: CustomText(text: "Anexar imagem", color: grey800),
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
          );
        });
  }

  Widget _emptyWidget() {
    return const SizedBox.shrink();
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
              onTap: () => _publicationPageController.selectedOption = index,
              child: Container(
                decoration: BoxDecoration(
                  color: selected ? primary : base,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 2,
                    color: selected ? primary : grey200,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: CustomText(
                    text: text,
                    color: selected ? base : grey800,
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
      // actions: [
      //   SizedBox(
      //     width: 80,
      //     height: 40,
      //     child: CustomButton(
      //       onPress: () {
      //         Navigator.of(context).pop();
      //       },
      //       text: "Fechar",
      //     ),
      //   ),
      // ],
    );
  }
}
