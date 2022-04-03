import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/pages/register/second_register_form/second_register_form_controller.dart';
import 'package:pet_hood/theme/colors.dart';

class SecondRegisterForm extends StatelessWidget {
  SecondRegisterForm({Key? key}) : super(key: key);

  final SecondRegisterFormController _secondRegisterFormController =
      SecondRegisterFormController();

  @override
  Widget build(BuildContext context) {
    var safePaddingBottom = MediaQuery.of(context).padding.bottom;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: LayoutBuilder(
        builder: ((context, constraints) => SingleChildScrollView(
              child: SizedBox(
                height: height,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    constraints.maxHeight > 550
                        ? SizedBox(height: height * 0.1)
                        : SizedBox(height: height * 0.04),
                    SvgPicture.asset("assets/images/app_logo.svg"),
                    SizedBox(height: height * 0.05),
                    const Padding(
                      padding: EdgeInsets.only(
                        right: 32,
                        left: 32,
                        bottom: 16,
                      ),
                      child: CustomInput(placeholderText: "Email"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 32,
                        left: 32,
                        bottom: 16,
                      ),
                      child: Obx(
                        () => CustomInput(
                          placeholderText: "Senha",
                          obscureText:
                              _secondRegisterFormController.hidePassword,
                          onIconPress: () =>
                              _secondRegisterFormController.hidePassword =
                                  !_secondRegisterFormController.hidePassword,
                          suffixIcon: const Icon(
                            Icons.visibility_off_outlined,
                            color: placeholder,
                          ),
                          suffixIconReverse: const Icon(
                            Icons.visibility_outlined,
                            color: placeholder,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 32,
                        left: 32,
                        bottom: 16,
                      ),
                      child: Obx(
                        () => CustomInput(
                          placeholderText: "Confirmar senha",
                          obscureText:
                              _secondRegisterFormController.hideConfirmPassword,
                          onIconPress: () => _secondRegisterFormController
                                  .hideConfirmPassword =
                              !_secondRegisterFormController
                                  .hideConfirmPassword,
                          suffixIcon: const Icon(
                            Icons.visibility_off_outlined,
                            color: placeholder,
                          ),
                          suffixIconReverse: const Icon(
                            Icons.visibility_outlined,
                            color: placeholder,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 32,
                        left: 32,
                        bottom: 16,
                      ),
                      child: CustomButton(text: "Cadastrar", onPress: () {}),
                    ),
                    const CustomText(
                      text: "Ao cadastrar você concorda com nossos",
                      color: grey800,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    InkWell(
                      onTap: () => Get.toNamed("/terms_of_use"),
                      child: const CustomText(
                        text: "Termos de Uso e Privacidade",
                        color: primary,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText(
                          text: "Já tem uma conta? ",
                          color: grey800,
                        ),
                        InkWell(
                          splashColor: inputColor,
                          highlightColor: inputColor,
                          onTap: () => {Get.back(), Get.back()},
                          child: const CustomText(
                            text: "Entrar",
                            color: primary,
                          ),
                        ),
                      ],
                      // ),
                    ),
                    SizedBox(height: safePaddingBottom + height * 0.06),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
