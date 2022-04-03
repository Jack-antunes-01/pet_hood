import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:pet_hood/constants/app_constants.dart';
import 'package:pet_hood/pages/terms_of_use/terms_of_use.dart';
import 'package:pet_hood/theme/colors.dart';

import 'pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: base,
      ),
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150),
      getPages: [
        GetPage(name: "/welcome", page: () => const WelcomePage()),
        GetPage(name: "/login", page: () => LoginPage()),
        GetPage(name: "/register", page: () => FirstRegisterForm()),
        GetPage(name: "/register_2", page: () => SecondRegisterForm()),
        GetPage(name: "/terms_of_use", page: () => const TermsOfUsePage()),
      ],
      initialRoute: "/welcome",
    );
  }
}
