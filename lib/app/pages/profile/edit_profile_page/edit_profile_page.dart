import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/api_controller.dart';
import 'package:pet_hood/app/controllers/user_controller.dart';
import 'package:pet_hood/app/pages/profile/edit_profile_page/edit_profile_page_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/utils/validators/username_validator.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final UserController _userController = Get.find();
  final EditProfilePageController _editProfilePageController =
      Get.put(EditProfilePageController());

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _editProfilePageController.emailController.text =
        _userController.userEntity.email;

    _editProfilePageController.usernameController.text =
        _userController.userEntity.userName;

    _editProfilePageController.bioController.text =
        _userController.userEntity.bio != null
            ? _userController.userEntity.bio!
            : "";
  }

  validateForm() async {
    final isValidForm = formKey.currentState!.validate();

    if (isValidForm) {
      _editProfilePageController.loading = true;

      String username =
          _editProfilePageController.usernameController.text.toLowerCase();
      String email = _userController.userEntity.email;
      String bio = _editProfilePageController.bioController.text.trim();

      final response = await ApiController().updateUserInfo(
        bio: bio,
        email: email,
        username: username,
      );

      if (response) {
        Get.back();
      }

      _editProfilePageController.loading = false;
    }
  }

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
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: CustomText(text: "Email", color: grey800),
              ),
              CustomText(
                text: _editProfilePageController.emailController.text,
                color: grey800,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 8),
                child: CustomText(text: "Nome de usuário", color: grey800),
              ),
              CustomInput(
                controller: _editProfilePageController.usernameController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9_]")),
                ],
                placeholderText: "Username",
                labelActive: false,
                validator: (username) => usernameValidator(
                  value: username,
                  isEnabled: true,
                ),
                maxLength: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 8),
                child: CustomText(text: "Bio", color: grey800),
              ),
              TextField(
                controller: _editProfilePageController.bioController,
                maxLines: 4,
                maxLength: 500,
                decoration: InputDecoration(
                  fillColor: inputColor,
                  filled: true,
                  hintText: "Escreva um pouco sobre você",
                  hintStyle: const TextStyle(color: placeholder),
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
                      color: grey200,
                      width: 2,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 20),
                child: CustomButton(
                    child: Obx(() => _buildButton()),
                    onPress: () => _editProfilePageController.loading
                        ? null
                        : validateForm()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    if (_editProfilePageController.loading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: base,
        ),
      );
    } else {
      return const CustomText(
        text: "Salvar",
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: base,
      );
    }
  }
}
