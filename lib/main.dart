import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_plate/screens/welocme_screen.dart';
import 'package:smart_plate/utilities/shared_data.dart';

void main() {
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', ''), Locale('ar', '')],
        startLocale: Locale('en', ''),
        path: 'assets/translations',
        fallbackLocale: Locale('en', ''),
        child: MyApp()
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SharedData>(
      create: (context) => SharedData(),
      child: CupertinoApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: CupertinoThemeData(brightness: Brightness.light),
        home: WelcomeScreen(),
      ),
    );
  }
}