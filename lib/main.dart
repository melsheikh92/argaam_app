import 'package:argaam_app/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:argaam_app/resources/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        color: AppTheme.primaryColor,
        theme: ThemeData(primaryColor: AppTheme.primaryColor),
        title: "أرقام",
        debugShowCheckedModeBanner: false,
        home: SplashScreenWidegt());
  }
}
