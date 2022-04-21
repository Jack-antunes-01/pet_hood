import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/core/entities/pet_entity.dart';
import 'package:pet_hood/app/theme/colors.dart';

import '../../../data/data.dart';
import '../pet_widget/pet_widget.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final PetCategory category = Get.arguments['category'];

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
      child: ExpansionTile(
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        trailing: const Icon(Icons.sort, color: grey800),
        childrenPadding: const EdgeInsets.only(right: 16, left: 16),
        title: const CustomText(
          text: "Filtros",
          color: grey800,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        children: [
          const CustomText(
            text: "Raça",
            color: grey800,
            fontSize: 18,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: CustomInput(
              placeholderText: "Raça",
              labelActive: false,
            ),
          ),
          const CustomText(
            text: "Data desaparecido/encontrado",
            color: grey800,
            fontSize: 18,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: CustomInput(
              placeholderText: "01/01/2022",
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CustomText(
                        text: "Cidade",
                        color: grey800,
                        fontSize: 18,
                      ),
                      CustomInput(
                          placeholderText: "Cidade", labelActive: false),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CustomText(
                        text: "Estado",
                        color: grey800,
                        fontSize: 18,
                      ),
                      CustomInput(
                          placeholderText: "Estado", labelActive: false),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 100,
                child: CustomButton(text: "Aplicar", onPress: () {}),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _list() {
    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.only(top: 20, left: 20),
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 1,
        childAspectRatio: 1 / 1,
        crossAxisSpacing: 0,
        children: getPetList()
            .where((element) => element.category == category)
            .map((item) {
          return PetWidget(pet: item, index: 1);
        }).toList(),
      ),
    );
  }

  getFiltredList() {
    var petList = getPetList();
    return petList.where((element) => element.category == category).map((item) {
      return PetWidget(pet: item, index: 1);
    }).toList();
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
        child: Icon(
          Icons.arrow_back,
          color: Colors.grey[800],
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
