import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pages/main.dart';
import 'services/db.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: DbService().settings.listenable(keys: ['darkMode']),
      builder: (context, box, widget) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: box.get('darkMode', defaultValue: false)
                ? Brightness.light
                : Brightness.dark,
            statusBarIconBrightness: box.get('darkMode', defaultValue: false)
                ? Brightness.light
                : Brightness.dark,
            systemNavigationBarIconBrightness:
                box.get('darkMode', defaultValue: false)
                    ? Brightness.light
                    : Brightness.dark,
          ),
          child: GetMaterialApp(
            title: 'Binoculars',
            debugShowCheckedModeBanner: false,
            themeMode: box.get('darkMode', defaultValue: false)
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: ThemeData(primarySwatch: Colors.cyan),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.black,
            ),
            defaultTransition: Transition.cupertino,
            popGesture: true,
            home: MainPage(),
          ),
        );
      },
    );
  }
}
