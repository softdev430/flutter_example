import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_project/pages/about.dart';
import 'package:test_project/pages/home.dart';
import 'package:test_project/utils/localizations.dart';

Future<Null> main() async {
  runApp(MaterialApp(
    localizationsDelegates: [
      AppLocalizationsDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    supportedLocales: [
      const Locale('en'), // English
      const Locale.fromSubtags(
          languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
    ],
    onGenerateTitle: (BuildContext context) =>
        AppLocalizations.of(context).title,
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: HomePage(),
    routes: <String, WidgetBuilder>{
      AboutPage.routeName: (BuildContext context) => AboutPage(),
    },
  ));
}
