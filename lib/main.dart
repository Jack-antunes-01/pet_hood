import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:pet_hood/app/bindings/initial_binding.dart';
import 'package:pet_hood/app/routes/routes.dart';
import 'package:pet_hood/app/routes/routes_list.dart';
import 'package:pet_hood/app/theme/colors.dart';

import 'app/constants/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      initialBinding: InitialBinding(),
      theme: ThemeData(
        splashColor: base.withOpacity(0.1),
        highlightColor: base.withOpacity(0.1),
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: base,
      ),
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150),
      getPages: RoutesList.routes,
      initialRoute: Routes.welcome,
    );
  }
}
