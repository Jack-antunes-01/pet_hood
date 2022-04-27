import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/register_controller.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/utils/regex/only_letters.dart';
import 'package:pet_hood/utils/validators/birth_date_validator.dart';
import 'package:pet_hood/utils/validators/name_validator.dart';

class FirstRegisterForm extends StatefulWidget {
  const FirstRegisterForm({Key? key}) : super(key: key);

  @override
  State<FirstRegisterForm> createState() => _FirstRegisterFormState();
}

class _FirstRegisterFormState extends State<FirstRegisterForm> {
  final RegisterController _registerController = Get.put(RegisterController());

  final formKey = GlobalKey<FormState>();

  bool validation = false;

  void validateForm() {
    setState(() {
      validation = true;
    });

    final isValidForm = formKey.currentState!.validate();

    if (isValidForm) {
      Get.toNamed(Routes.register2);
    }
  }

  @override
  Widget build(BuildContext context) {
    var safePaddingBottom = MediaQuery.of(context).padding.bottom;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: height * 0.1),
                SvgPicture.asset(
                  "assets/images/app_logo.svg",
                  color: primary,
                ),
                SizedBox(height: height * 0.05),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 32,
                    left: 32,
                    bottom: 16,
                  ),
                  child: CustomInput(
                    controller: _registerController.nameController,
                    placeholderText: "Nome",
                    validator: (value) => nameValidator(
                      value: value,
                      isEnabled: validation,
                    ),
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    maxLength: 50,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        onlyLettersWithBlank,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 32,
                    left: 32,
                    bottom: 16,
                  ),
                  child: CustomInput(
                    controller: _registerController.birthDateController,
                    placeholderText: "Data de nascimento",
                    validator: (value) => birthDateValidator(
                      value: value,
                      isEnabled: validation,
                    ),
                    inputFormatters: [
                      MaskTextInputFormatter(mask: "##/##/####"),
                    ],
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (v) => validateForm(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 32,
                    left: 32,
                    bottom: 16,
                  ),
                  child: CustomButton(
                    child: const CustomText(
                      text: "Continuar",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: base,
                    ),
                    onPress: () => validateForm(),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                        text: "Já tem uma conta? ", color: grey800),
                    InkWell(
                      splashColor: inputColor,
                      highlightColor: inputColor,
                      onTap: () => Get.back(),
                      child: const CustomText(text: "Entrar", color: primary),
                    ),
                  ],
                ),
                SizedBox(height: safePaddingBottom + height * 0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
