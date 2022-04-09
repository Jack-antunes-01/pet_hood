import 'package:flutter/material.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/theme/colors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 16),
            child: CustomInput(
              placeholderText: "Digite algo..",
              prefixIcon: Icon(Icons.search, color: grey600),
              labelActive: false,
            ),
          ),
          Column(
            children: List.generate(5, (index) => _peopleCard()),
          ),
        ],
      ),
    );
  }

  Widget _peopleCard() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        splashColor: grey200,
        highlightColor: grey200,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: grey200, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      "https://www.gettyimages.pt/gi-resources/images/500px/983794168.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
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
