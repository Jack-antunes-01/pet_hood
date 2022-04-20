import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/pages/login/login_page_controller.dart';
import 'package:pet_hood/routes/routes.dart';
import 'package:pet_hood/theme/colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginPageController _loginPageController =
      Get.put(LoginPageController());

  @override
  Widget build(BuildContext context) {
    var safePaddingBottom = MediaQuery.of(context).padding.bottom;
    var safePaddingTop = MediaQuery.of(context).padding.top;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: safePaddingTop + height * 0.1),
              SvgPicture.asset(
                "assets/images/app_logo.svg",
                color: primary,
              ),
              SizedBox(height: height * 0.05),
              const Padding(
                padding: EdgeInsets.only(right: 32, left: 32, bottom: 16),
                child: CustomInput(
                  placeholderText: "Email",
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(right: 32, left: 32, bottom: 16),
                  child: Obx(
                    () => CustomInput(
                      placeholderText: "Senha",
                      obscureText: _loginPageController.hidePassword,
                      onIconPress: () => _loginPageController.hidePassword =
                          !_loginPageController.hidePassword,
                      suffixIcon: const Icon(
                        Icons.visibility_off_outlined,
                        color: placeholder,
                      ),
                      suffixIconReverse: const Icon(
                        Icons.visibility_outlined,
                        color: placeholder,
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 32, left: 32, bottom: 20),
                child: CustomButton(
                  text: "Entrar",
                  onPress: () => Get.offAllNamed("/"),
                ),
              ),
              InkWell(
                splashColor: inputColor,
                highlightColor: inputColor,
                onTap: () {},
                child: const CustomText(
                  text: "Esqueceu a senha?",
                  color: primary,
                ),
              ),
              // SizedBox(height: height * 0.1),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(text: "Não tem uma conta? ", color: grey800),
                  InkWell(
                    splashColor: inputColor,
                    highlightColor: inputColor,
                    onTap: () => Get.toNamed(Routes.register),
                    child:
                        const CustomText(text: "Cadastre-se", color: primary),
                  ),
                ],
                // ),
              ),
              SizedBox(height: safePaddingBottom + height * 0.06),
            ],
          ),
        ),
      ),
    );
  }
}
