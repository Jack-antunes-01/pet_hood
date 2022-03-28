import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pet_hood/constants/app_constants.dart';
import 'package:pet_hood/features/welcome/presentation/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(fontFamily: 'Nunito'),
      getPages: [
        GetPage(name: "/welcome", page: () => const WelcomePage()),
      ],
      initialRoute: "/welcome",
    );
  }
}
