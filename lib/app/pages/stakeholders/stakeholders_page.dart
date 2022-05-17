import 'package:flutter/material.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/theme/colors.dart';

class StakeholdersPage extends StatelessWidget {
  const StakeholdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: CustomText(
                  text: "Nossos parceiros estão listados aqui: ",
                  color: grey800,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Image.asset(
                      "assets/images/uniube_logo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: CustomText(
                        text: "Universidade de Uberaba - UNIUBE",
                        color: grey800,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: CustomText(
                  text: "Seja um parceiro você também!",
                  color: grey800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
