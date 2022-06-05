import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/pages/login/login_page_controller.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/user_entity.dart';
import 'package:pet_hood/database/api_adapter.dart';
import 'package:pet_hood/utils/validators/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginPageController _loginPageController =
      Get.put(LoginPageController());

  final UserController _userController = Get.find();
  final ApiAdapter _apiAdapter = Get.find();

  final formKey = GlobalKey<FormState>();

  validateLogin() async {
    final isValidForm = formKey.currentState!.validate();

    if (isValidForm) {
      _loginPageController.loading = true;
      try {
        var response = await _apiAdapter.post(
          '/sessions',
          data: {
            "email": _loginPageController.emailController.text,
            "password": _loginPageController.passwordController.text,
          },
          options: Options(
            headers: {
              "requiresToken": false,
            },
          ),
        );

        UserEntity userEntity = UserEntity(
          id: response.data['user']['id'],
          email: response.data['user']['email'],
          name: response.data['user']['name'],
          userName: response.data['user']['user_name'],
          phoneNumber: response.data['user']['phone_number'],
          profileImage: response.data['user']['profile_image'],
          backgroundImage: response.data['user']['background_image'],
          birthDate: response.data['user']['date_birth'],
          bio: response.data['user']['bio'],
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response.data['token']);

        _userController.userEntity = userEntity;
        Get.offAllNamed("/");
      } catch (e) {
        Get.snackbar(
          "Erro",
          "Email ou senha incorretos",
          duration: const Duration(
            seconds: 2,
          ),
          backgroundColor: primary,
          colorText: base,
        );
      }
      _loginPageController.loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var safePaddingBottom = MediaQuery.of(context).padding.bottom;
    var safePaddingTop = MediaQuery.of(context).padding.top;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
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
                Padding(
                  padding:
                      const EdgeInsets.only(right: 32, left: 32, bottom: 16),
                  child: CustomInput(
                    controller: _loginPageController.emailController,
                    placeholderText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) => emailValidator(
                      value: email,
                      isEnabled: true,
                    ),
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(right: 32, left: 32, bottom: 16),
                    child: Obx(
                      () => CustomInput(
                        controller: _loginPageController.passwordController,
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
                        validator: (password) =>
                            password != null && password.isNotEmpty
                                ? null
                                : "Digite sua senha",
                      ),
                    )),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 32, left: 32, bottom: 20),
                  child: Obx(
                    () => CustomButton(
                      child: _buildButton(),
                      onPress: () =>
                          _loginPageController.loading ? null : validateLogin(),
                    ),
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
                    const CustomText(
                        text: "Não tem uma conta? ", color: grey800),
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
      ),
    );
  }

  Widget _buildButton() {
    if (_loginPageController.loading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: base,
        ),
      );
    } else {
      return const CustomText(
        text: "Entrar",
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: base,
      );
    }
  }
}
