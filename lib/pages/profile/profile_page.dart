import 'package:flutter/material.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/components/user_avatar/user.avatar.dart';
import 'package:pet_hood/data/data.dart';
import 'package:pet_hood/entities/pet.dart';
import 'package:pet_hood/pages/profile/pet_profile_widget/pet_profile_widget.dart';
import 'package:pet_hood/theme/colors.dart';

import '../adoption/pet_widget/pet_widget.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final List pets = getPetList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context),
            _bio(),
            _myPets(),
            _adoption(),
            _publications(),
          ],
        ),
      ),
    );
  }

  Widget _publications() {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
          ),
          child: CustomText(
            text: "Publicações",
            color: grey800,
          ),
        ),
      ],
    );
  }

  Widget _adoption() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16, bottom: 8, left: 20, right: 20),
          child: CustomText(text: "Adoção", color: grey800),
        ),
        _noAdoptionPets(),
        SizedBox(
          height: 280,
          child: ListView(
            padding: const EdgeInsets.only(left: 20, right: 4),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: getPetList()
                .where((element) => element.category == PetCategory.adoption)
                .map((item) {
              return PetWidget(pet: item, index: 1);
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child:
              CustomButton(text: "Cadastrar pet para adoção", onPress: () {}),
        ),
      ],
    );
  }

  Widget _myPets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8, left: 20, right: 20),
          child: CustomText(text: "Meus Pets", color: grey800),
        ),
        _noPets(),
        SizedBox(
          height: 280,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: buildNewestPet(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: CustomButton(text: "Adicionar pet", onPress: () {}),
        ),
      ],
    );
  }

  List<Widget> buildNewestPet() {
    List<Widget> list = [];

    for (var i = 0; i < pets.length; i++) {
      if (pets[i].newest) {
        list.add(
          PetProfileWidget(
            pet: pets[i],
            index: i,
          ),
        );
      }
    }

    return list;
  }

  Widget _noPets() {
    return const Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 16,
      ),
      child: CustomText(
        text:
            "Você não adicionou nenhum pet. Adicione e mostre para todos que acessarem seu perfil!",
        color: grey600,
      ),
    );
  }

  Widget _noAdoptionPets() {
    return const Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 16,
      ),
      child: CustomText(
        text: "Você não possui nenhum pet para adoção.",
        color: grey600,
      ),
    );
  }

  Widget _bio() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: const ListTileTheme(
              contentPadding: EdgeInsets.zero,
              dense: true,
              horizontalTitleGap: 0.0,
              minLeadingWidth: 0,
              child: ExpansionTile(
                initiallyExpanded: true,
                tilePadding: EdgeInsets.only(right: 20, left: 20),
                childrenPadding:
                    EdgeInsets.only(right: 20, left: 20, bottom: 10),
                title: CustomText(
                  text: "Bio",
                  color: grey800,
                ),
                children: [
                  CustomText(
                    text:
                        "Um dos fundadores da Pet Hood, apaixonado por animais!",
                    color: grey600,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/user_avatar.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Material(
                  color: primary,
                  borderRadius: BorderRadius.circular(4),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () {},
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(Icons.edit, color: base, size: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 10,
            left: 10,
            child: Row(
              children: [
                Stack(
                  children: [
                    const UserAvatar(size: 100),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        color: primary,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: base,
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: base,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          CustomText(
                            text: "Jackson Antunes",
                            color: grey800,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          CustomText(
                            text: "@Jack_antunes01",
                            color: grey600,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Material(
                    color: primary,
                    borderRadius: BorderRadius.circular(4),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.edit_note,
                          color: base,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              CustomText(
                text: "Sobre o usuário",
                color: grey800,
                fontWeight: FontWeight.bold,
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
          SelectableText(
            "Jackson Antunes Batista",
            style: TextStyle(
              color: grey800,
            ),
          ),
          SizedBox(height: 10),
          SelectableText(
            "@Jack_antunes01",
            style: TextStyle(
              color: grey800,
            ),
          ),
        ],
      ),
    );
  }
}