import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/routes/routes.dart';
import 'package:pet_hood/theme/colors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 20, left: 20, top: 16, bottom: 16),
          child: CustomInput(
            placeholderText: "Digite algo..",
            prefixIcon: Icon(Icons.search, color: grey600),
            labelActive: false,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Column(
                children: List.generate(7, (index) => _peopleCard()),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _peopleCard() {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Get.toNamed(Routes.externalProfile);
      },
      splashColor: grey200,
      highlightColor: grey200,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: grey200,
              width: 2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: UserAvatar(
                  size: 60,
                ),
              ),
              Column(
                children: const [
                  CustomText(
                    text: "Jackson Antunes",
                    color: grey800,
                    fontSize: 18,
                  ),
                  CustomText(text: "@Jack_antunes01", color: grey600),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
