import 'package:flutter/material.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/theme/colors.dart';

class BuildPetFeature extends StatelessWidget {
  final String value;
  final String feature;

  const BuildPetFeature({
    Key? key,
    required this.value,
    required this.feature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: grey200,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            CustomText(
              text: value,
              color: grey800,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            const SizedBox(height: 4),
            CustomText(
              text: feature,
              color: grey600,
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}
