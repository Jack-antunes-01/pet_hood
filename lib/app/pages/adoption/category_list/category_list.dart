import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/adoption_controller.dart';
import 'package:pet_hood/core/entities/pet_entity.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/utils/regex/only_letters.dart';
import 'package:pet_hood/utils/validators/date_validator.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final AdoptionController _adoptionController = Get.find();

  late PetCategory category;

  final formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> expansionKey = GlobalKey();

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    category = _adoptionController.petCategory;
  }

  @override
  void dispose() {
    super.dispose();

    _adoptionController.filterLoading = false;
    _adoptionController.filteredPetList = [];
    _adoptionController.breed.text = "";
    _adoptionController.dateSearch.text = "";
    _adoptionController.city.text = "";
    _adoptionController.state.text = "";
  }

  validateForm() async {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      final _breed = _adoptionController.breed.text.toLowerCase();
      final _dateSearch = _adoptionController.dateSearch.text;
      final _city = _adoptionController.city.text.toLowerCase();
      final _state = _adoptionController.state.text.toLowerCase();

      _adoptionController.filterLoading = true;
      await Future.delayed(const Duration(seconds: 1), () {
        /// If evetything is empty, show list and collapse
        if (_breed.isEmpty &&
            _dateSearch.isEmpty &&
            _city.isEmpty &&
            _state.isEmpty) {
          _adoptionController.filteredPetList = [];
          expansionKey.currentState!.collapse();
        } else {
          _adoptionController.filteredPetList =
              _adoptionController.petList.where((element) {
            DateTime createdAtDate = element.createdAt;
            var day = createdAtDate.day;
            var month = createdAtDate.month < 10
                ? "0${createdAtDate.month}"
                : createdAtDate.month;
            var year = createdAtDate.year;
            String createdAt = "$day/$month/$year";

            return element.category == category &&
                ((_breed.isNotEmpty &&
                        element.breed!.toLowerCase().contains(_breed)) ||
                    (_dateSearch.isNotEmpty && _dateSearch == createdAt) ||
                    (_city.isNotEmpty &&
                        element.city.toLowerCase().contains(_city)) ||
                    (_state.isNotEmpty &&
                        element.state.toLowerCase().contains(_state)));
          }).toList();

          if (_adoptionController.filteredPetList.isEmpty) {
            Get.snackbar(
              "Pet",
              "Nenhum pet encontrado.",
              duration: const Duration(milliseconds: 1200),
              backgroundColor: primary,
              colorText: base,
            );
          } else {
            expansionKey.currentState!.collapse();
          }
        }
      });
      _adoptionController.filterLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _filter(),
          _list(),
        ],
      ),
    );
  }

  Widget _filter() {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ).copyWith(dividerColor: Colors.transparent),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: ExpansionTileCard(
          key: expansionKey,
          duration: const Duration(milliseconds: 150),
          borderRadius: BorderRadius.zero,
          elevation: 0,
          baseColor: base,
          onExpansionChanged: (value) {
            setState(() {
              isExpanded = value;
            });
          },
          trailing: const Icon(Icons.sort, color: grey800),
          title: const CustomText(
            text: "Filtros",
            color: grey800,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: "Raça",
                    color: grey800,
                    fontSize: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 4),
                    child: CustomInput(
                      controller: _adoptionController.breed,
                      placeholderText: "Vira-lata",
                      labelActive: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(onlyLetters),
                      ],
                    ),
                  ),
                  CustomText(
                    text: category == PetCategory.adoption
                        ? "Data publicação"
                        : "Data desaparecido/encontrado",
                    color: grey800,
                    fontSize: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 4),
                    child: CustomInput(
                      controller: _adoptionController.dateSearch,
                      placeholderText: "01/01/2022",
                      labelActive: false,
                      validator: (value) => dateValidator(
                        value: value,
                        isNullable: true,
                      ),
                      inputFormatters: [
                        MaskTextInputFormatter(mask: "##/##/####"),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 4),
                                child: CustomText(
                                  text: "Cidade",
                                  color: grey800,
                                  fontSize: 18,
                                ),
                              ),
                              CustomInput(
                                controller: _adoptionController.city,
                                placeholderText: "Uberaba",
                                labelActive: false,
                                maxLength: 30,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(onlyLetters)
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 4),
                                child: CustomText(
                                  text: "Estado",
                                  color: grey800,
                                  fontSize: 18,
                                ),
                              ),
                              CustomInput(
                                controller: _adoptionController.state,
                                placeholderText: "MG",
                                labelActive: false,
                                maxLength: 2,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    onlyLettersSample,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 120,
                        child: CustomButton(
                            child: Obx(() => _buildButton()),
                            onPress: () => validateForm()),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
    return _adoptionController.filterLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: base,
            ),
          )
        : const CustomText(
            text: "Aplicar",
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: base,
          );
  }

  Widget _list() {
    return Expanded(
      child: Obx(
        () => GridView.count(
          padding: const EdgeInsets.only(top: 20, left: 20),
          physics: const BouncingScrollPhysics(),
          crossAxisCount: 1,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 0,
          children: _adoptionController.filteredPetList.isNotEmpty
              ? _adoptionController.filteredPetList
                  .map((e) => PetWidget(pet: e, index: 1))
                  .toList()
              : _adoptionController.petList
                  .where((element) => element.category == category)
                  .map((item) {
                  return PetWidget(pet: item, index: 1);
                }).toList(),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: CustomText(
        text: getTitle(),
        color: grey800,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(
          Icons.arrow_back,
          color: grey800,
        ),
      ),
    );
  }

  getTitle() {
    switch (category) {
      case PetCategory.adoption:
        return "Adoção";
      case PetCategory.disappear:
        return "Desaparecidos";
      case PetCategory.found:
        return "Encontrados";
      default:
        return "unknown";
    }
  }
}
