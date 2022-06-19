import 'package:flutter/material.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/theme/colors.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        appBar: AppBar(),
      ),
      body: const Center(
        child: CustomText(
          text: "Ranking - Em breve..",
          color: grey800,
        ),
      ),
    );
  }
}
