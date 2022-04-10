import 'package:flutter/material.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/theme/colors.dart';

class StakeholdersPage extends StatelessWidget {
  const StakeholdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        appBar: AppBar(),
      ),
      body: const Center(
        child: CustomText(
          text: "Parcerias - Não implementado",
          color: grey800,
        ),
      ),
    );
  }
}
