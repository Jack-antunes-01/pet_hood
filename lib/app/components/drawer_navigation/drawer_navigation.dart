import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pet_hood/app/controllers/api_controller.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/components/components.dart';

import '../../constants/constants.dart';
import '../../theme/colors.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  void logout() {
    Get.offAllNamed(Routes.login);
    Get.deleteAll(force: true);
    ApiController().logout();
  }

  @override
  Widget build(BuildContext context) {
    var safePaddingTop = MediaQuery.of(context).padding.top;
    var height = MediaQuery.of(context).size.height;
    return Drawer(
      elevation: 0,
      backgroundColor: primary,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: safePaddingTop + height * 0.01,
                    bottom: 12,
                  ),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              appTitle,
                              style: TextStyle(
                                color: base,
                                fontFamily: "Grand Hotel",
                                fontSize: 24,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            "assets/images/app_logo.svg",
                            width: 32,
                            color: base,
                          ),
                        ],
                      ),
                      Positioned(
                        top: -15,
                        right: 0,
                        child: IconButton(
                          splashRadius: 20,
                          icon: const Icon(
                            Icons.close,
                            color: base,
                            size: 25,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      )
                    ],
                  ),
                ),
                _divider(),
                _listTileItem(
                  text: "Parcerias",
                  icons: Icons.handshake_outlined,
                  onPress: () {
                    Get.toNamed(Routes.stakeholders);
                  },
                ),
                // _divider(),
                // _listTileItem(
                //   text: "Ranking",
                //   icons: Icons.star_border_outlined,
                //   onPress: () {
                //     Get.toNamed(Routes.ranking);
                //   },
                // ),
                _divider(),
                _listTileItem(
                  text: "Sobre nós",
                  icons: Icons.info_outline,
                  onPress: () {
                    Get.toNamed(Routes.aboutUs);
                  },
                ),
                _divider(),
                _listTileItem(
                  text: "Sair",
                  icons: Icons.exit_to_app,
                  onPress: () => logout(),
                ),
                _divider(),
              ],
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed(Routes.termsOfUse),
            child: const CustomText(
              text: "Termos de uso e privacidade",
              color: base,
            ),
          ),
          SizedBox(height: height * 0.05)
        ],
      ),
    );
  }

  Widget _listTileItem({
    String? imagePath,
    IconData? icons,
    required String text,
    required VoidCallback onPress,
  }) {
    return ListTile(
      title: Row(
        children: [
          imagePath != null
              ? SvgPicture.asset(
                  imagePath,
                  width: 30,
                )
              : Icon(
                  icons,
                  color: base,
                  size: 30,
                ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: CustomText(
              text: text,
              color: base,
            ),
          ),
        ],
      ),
      onTap: onPress,
    );
  }

  Widget _divider() {
    return const Divider(color: base, thickness: 1, height: 0);
  }
}
