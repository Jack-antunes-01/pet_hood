import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:pet_hood/app/components/components.dart';
import 'package:pet_hood/app/controllers/external_profile_controller.dart';
import 'package:pet_hood/app/pages/pages.dart';

class ExternalProfilePage extends StatefulWidget {
  const ExternalProfilePage({Key? key}) : super(key: key);

  @override
  State<ExternalProfilePage> createState() => _ExternalProfilePageState();
}

class _ExternalProfilePageState extends State<ExternalProfilePage> {
  final ExternalProfileController _externalProfileController = Get.find();

  goBack() {
    _externalProfileController.clear();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        onBackPress: goBack,
        appBar: AppBar(),
      ),
      body: const ProfilePage(isOwner: false),
    );
  }
}
