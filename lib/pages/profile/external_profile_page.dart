import 'package:flutter/material.dart';
import 'package:pet_hood/components/components.dart';
import 'package:pet_hood/pages/pages.dart';

class ExternalProfilePage extends StatelessWidget {
  const ExternalProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        appBar: AppBar(),
      ),
      body: ProfilePage(isOwner: false),
    );
  }
}
