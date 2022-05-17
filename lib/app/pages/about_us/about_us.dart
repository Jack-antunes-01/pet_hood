import 'package:flutter/material.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/constants/constants.dart';
import 'package:pet_hood/app/theme/colors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var safePaddingBottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBarHeader(
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: CustomText(
                  color: grey800,
                  text: "Sobre a empresa $appTitle",
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 20,
                  left: 20,
                  bottom: safePaddingBottom + 20,
                ),
                child: const CustomText(
                  text: aboutCompany,
                  color: grey800,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
