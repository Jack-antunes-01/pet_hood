import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/api_controller.dart';
import 'package:pet_hood/app/controllers/controllers.dart';
import 'package:pet_hood/app/controllers/external_profile_controller.dart';
import 'package:pet_hood/app/theme/colors.dart';
import 'package:pet_hood/core/entities/user_entity.dart';

class SearchPage extends StatelessWidget {
  final ExternalProfileController _externalProfileController = Get.find();
  final UserController _userController = Get.find();

  SearchPage({Key? key}) : super(key: key);

  void goToExternalProfile(UserEntity user) async {
    await ApiController().goToExternalProfileById(
      userId: user.id,
    );
  }

  void validateForm() async {
    try {
      if (_externalProfileController.searchController.text.length > 2) {
        _externalProfileController.loadingList = true;
        await ApiController().searchUsers(
          textToSearch: _externalProfileController.searchController.text,
        );
        _externalProfileController.loadingList = false;
      } else {
        _externalProfileController.loadingList = false;
        Get.snackbar(
          "Busca",
          "Coloque pelo menos 3 caracteres para que a busca seja mais precisa!",
          duration: const Duration(seconds: 2),
          backgroundColor: primary,
          colorText: base,
        );
      }
    } catch (e) {
      _externalProfileController.loadingList = false;
      Get.snackbar(
        "Erro",
        "Erro ao buscar usuários",
        duration: const Duration(seconds: 2),
        backgroundColor: primary,
        colorText: base,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 20, left: 20, top: 16, bottom: 16),
          child: CustomInput(
            controller: _externalProfileController.searchController,
            placeholderText: "Digite algo..",
            prefixIcon: const Icon(Icons.search, color: grey600),
            labelActive: false,
            onFieldSubmitted: (v) => validateForm(),
          ),
        ),
        Expanded(
          child: Obx(
            () => _externalProfileController.loadingList
                ? _buildLoading()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: _externalProfileController.userList.isEmpty
                        ? const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: CustomText(
                                text:
                                    "Não há nada aqui, tente procurar alguém!",
                                color: grey800,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _peopleCard(
                                _externalProfileController.userList[index],
                              ),
                            ),
                            itemCount:
                                _externalProfileController.userList.length,
                          ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          color: primary,
        ),
      ),
    );
  }

  Widget _peopleCard(UserEntity user) {
    return user.id != _userController.userEntity.id
        ? InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => goToExternalProfile(user),
            splashColor: grey200,
            highlightColor: grey200,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: grey200,
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: UserAvatar(
                        size: 60,
                        avatar: user.profileImage,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: user.name,
                          color: grey800,
                          fontSize: 18,
                        ),
                        CustomText(text: "@${user.userName}", color: grey600),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
