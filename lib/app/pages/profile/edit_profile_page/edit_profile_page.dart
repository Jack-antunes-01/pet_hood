import 'package:flutter/material.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/theme/colors.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        appBar: AppBar(),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: CustomText(text: "Email", color: grey800),
            ),
            const CustomInput(
              placeholderText: "Jackson.contato24@hotmail.com",
              labelActive: false,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16, bottom: 8),
              child: CustomText(text: "Nome de usuário", color: grey800),
            ),
            const CustomInput(
              placeholderText: "Jackson_antunes",
              labelActive: false,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16, bottom: 8),
              child: CustomText(text: "Bio", color: grey800),
            ),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                fillColor: inputColor,
                filled: true,
                hintText: "Escreva um pouco sobre você",
                contentPadding: const EdgeInsets.all(16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: grey200,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: primary,
                    width: 2,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 20),
              child: CustomButton(
                  child: const CustomText(
                    text: "Salvar",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: base,
                  ),
                  onPress: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
