import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/pages/register/first_register_form/fisrt_register_form_controller.dart';
import 'package:pet_hood/routes/routes.dart';
import 'package:pet_hood/theme/colors.dart';

class FirstRegisterForm extends StatelessWidget {
  FirstRegisterForm({Key? key}) : super(key: key);

  final FirstRegisterFormController _firstRegisterFormController =
      Get.put(FirstRegisterFormController());

  @override
  Widget build(BuildContext context) {
    var safePaddingBottom = MediaQuery.of(context).padding.bottom;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: height * 0.1),
              SvgPicture.asset("assets/images/app_logo.svg"),
              SizedBox(height: height * 0.05),
              const Padding(
                padding: EdgeInsets.only(
                  right: 32,
                  left: 32,
                  bottom: 16,
                ),
                child: CustomInput(placeholderText: "Nome"),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 32,
                  left: 32,
                  bottom: 16,
                ),
                child: CustomInput(
                  controller: _firstRegisterFormController.dateController,
                  placeholderText: "Data de nascimento",
                  readOnly: true,
                  suffixIconReverse: const Icon(
                    Icons.calendar_month_outlined,
                    color: primary,
                  ),
                  onIconPress: () async =>
                      await _firstRegisterFormController.selectDate(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 32,
                  left: 32,
                  bottom: 16,
                ),
                child: CustomButton(
                  text: "Continuar",
                  onPress: () => Get.toNamed(Routes.register2),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(text: "Já tem uma conta? ", color: grey800),
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
    );
  }
}
