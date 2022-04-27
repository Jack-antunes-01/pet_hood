import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/constants/app_constants.dart';
import 'package:pet_hood/app/controllers/register_controller.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/user_entity.dart';
import 'package:pet_hood/utils/validators/confirm_password_validator.dart';
import 'package:pet_hood/utils/validators/email_validator.dart';

class SecondRegisterForm extends StatefulWidget {
  const SecondRegisterForm({Key? key}) : super(key: key);

  @override
  State<SecondRegisterForm> createState() => _SecondRegisterFormState();
}

class _SecondRegisterFormState extends State<SecondRegisterForm> {
  final RegisterController _registerController = Get.find();
  final UserController _userController = Get.find();

  bool validation = false;
  double _strength = 0;
  String _displayText = "Vazio";

  final double _maxStrength = 1.0;

  bool hasUppercase = false;
  bool hasDigits = false;
  bool hasLowercase = false;
  bool hasMinLength = false;
  bool hasSpecialCharacters = false;

  final formKey = GlobalKey<FormState>();

  _checkPassword(String? value) {
    if (value != null) {
      String _password = value.trim();

      setState(() {
        hasMinLength = _password.length > 7;
        hasLowercase = _password.contains(RegExp(r'[a-z]'));
        hasUppercase = _password.contains(RegExp(r'[A-Z]'));
        hasDigits = _password.contains(RegExp(r'[0-9]'));
        hasSpecialCharacters =
            _password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      });

      int passwordStrength = 0;
      passwordStrength = passwordStrength +
          (hasMinLength ? 1 : 0) +
          (hasLowercase ? 1 : 0) +
          (hasUppercase ? 1 : 0) +
          (hasSpecialCharacters ? 1 : 0) +
          (hasDigits ? 1 : 0);

      switch (passwordStrength) {
        case 1:
          setState(() {
            _strength = 1 / 5;
            _displayText = "Muito Fraca";
          });
          break;
        case 2:
          setState(() {
            _strength = 2 / 5;
            _displayText = "Fraca";
          });
          break;
        case 3:
          setState(() {
            _strength = 3 / 5;
            _displayText = "Média";
          });
          break;
        case 4:
          setState(() {
            _strength = 4 / 5;
            _displayText = "Forte";
          });
          break;
        case 5:
          setState(() {
            _strength = 1;
            _displayText = "Muito Forte";
          });
          break;
        default:
          setState(() {
            _strength = 0;
            _displayText = "Vazio";
          });
          break;
      }
    } else {
      setState(() {
        _strength = 0;
        _displayText = "Vazio";
      });
    }
  }

  void validateForm() async {
    setState(() {
      validation = true;
    });

    final isValidForm = formKey.currentState!.validate();

    if (isValidForm) {
      if (_strength == _maxStrength) {
        _registerController.loading = true;
        await Future.delayed(const Duration(seconds: 2), () {
          UserEntity userEntity = _userController.userEntity;

          String name = _registerController.nameController.text;
          String username = name.split(" ").join("_").toLowerCase();

          userEntity.id = userId;
          userEntity.name = name;
          userEntity.userName = username;
          userEntity.email = _registerController.emailController.text;

          _userController.userEntity = userEntity;
          _userController.password =
              _registerController.passwordController.text;

          Get.offAllNamed(Routes.home);
        });
        _registerController.loading = false;
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _registerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var safePaddingBottom = MediaQuery.of(context).padding.bottom;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: LayoutBuilder(
        builder: ((context, constraints) => SingleChildScrollView(
              child: SizedBox(
                height: height,
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      constraints.maxHeight > 550
                          ? SizedBox(height: height * 0.1)
                          : SizedBox(height: height * 0.04),
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
                          controller: _registerController.emailController,
                          placeholderText: "Email",
                          validator: (email) => emailValidator(
                            value: email,
                            isEnabled: validation,
                          ),
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 32,
                          left: 32,
                          bottom: 16,
                        ),
                        child: Obx(
                          () => Column(
                            children: [
                              CustomInput(
                                controller:
                                    _registerController.passwordController,
                                placeholderText: "Senha",
                                onChanged: (value) => _checkPassword(value),
                                obscureText: _registerController.hidePassword,
                                onIconPress: () =>
                                    _registerController.hidePassword =
                                        !_registerController.hidePassword,
                                suffixIcon: const Icon(
                                  Icons.visibility_off_outlined,
                                  color: placeholder,
                                ),
                                suffixIconReverse: const Icon(
                                  Icons.visibility_outlined,
                                  color: placeholder,
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                              LinearPercentIndicator(
                                percent: _strength,
                                animateFromLastPercent: true,
                                animation: true,
                                padding: EdgeInsets.zero,
                                animationDuration: 300,
                                backgroundColor: grey200,
                                progressColor: getColor(),
                                lineHeight: 4,
                              ),
                              AnimatedSwitcher(
                                duration: const Duration(seconds: 1),
                                child: _strength == _maxStrength
                                    ? const SizedBox.shrink()
                                    : Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: CustomText(
                                                    text:
                                                        "Nível da senha: $_displayText",
                                                    color: grey800,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          _buildPopupDialog(
                                                              context),
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.info_outline,
                                                    color: grey800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
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
                            controller:
                                _registerController.confirmPasswordController,
                            placeholderText: "Confirmar senha",
                            obscureText:
                                _registerController.hideConfirmPassword,
                            onIconPress: () =>
                                _registerController.hideConfirmPassword =
                                    !_registerController.hideConfirmPassword,
                            suffixIcon: const Icon(
                              Icons.visibility_off_outlined,
                              color: placeholder,
                            ),
                            suffixIconReverse: const Icon(
                              Icons.visibility_outlined,
                              color: placeholder,
                            ),
                            textInputAction: TextInputAction.done,
                            validator: (value) => confirmPasswordValidator(
                              isEnabled: validation,
                              password:
                                  _registerController.passwordController.text,
                              confirmPassword: _registerController
                                  .confirmPasswordController.text,
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
                          () => CustomButton(
                            child: _buildButton(),
                            onPress: () => validateForm(),
                          ),
                        ),
                      ),
                      const CustomText(
                        text: "Ao cadastrar você concorda com nossos",
                        color: grey800,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      InkWell(
                        onTap: () => Get.toNamed(Routes.termsOfUse),
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
              ),
            )),
      ),
    );
  }

  getColor() {
    if (_strength <= 1 / 5) {
      return red;
    } else if (_strength == 2 / 5) {
      return adoptionBackground;
    } else if (_strength == 3 / 5) {
      return adoptionFont;
    } else if (_strength == 4 / 5) {
      return primary;
    } else {
      return Colors.green;
    }
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              CustomText(
                text: "A senha deve conter:",
                color: grey800,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.close,
              size: 28,
              color: primary,
            ),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "1 letra maiúscula (A-Z)",
            color: hasUppercase ? Colors.green : red,
          ),
          CustomText(
            text: "1 letra minúscula (a-z)",
            color: hasLowercase ? Colors.green : red,
          ),
          CustomText(
            text: "1 número (0-9)",
            color: hasDigits ? Colors.green : red,
          ),
          CustomText(
            text: "1 caracter especial (!@#\$%&*)",
            color: hasSpecialCharacters ? Colors.green : red,
          ),
          CustomText(
            text: "Mínimo de 8 dígitos",
            color: hasMinLength ? Colors.green : red,
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    if (_registerController.loading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: base,
        ),
      );
    } else {
      return const CustomText(
        text: "Cadastrar",
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: base,
      );
    }
  }
}
