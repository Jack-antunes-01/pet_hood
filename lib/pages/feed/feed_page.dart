import 'package:flutter/material.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/theme/colors.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: inputColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: Column(
            children: [
              const NormalPublication(),
              AdoptionPublication(),
              MissingPublication(),
              FoundPublication(),
            ],
          ),
        ),
      ),
    );
  }
}
