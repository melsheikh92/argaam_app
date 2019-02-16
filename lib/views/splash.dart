import 'dart:async';

import 'package:argaam_app/resources/colors.dart';
import 'package:argaam_app/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreenWidegt extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashState();
  }
}

class SplashState extends State<SplashScreenWidegt>
    with SingleTickerProviderStateMixin {
  Timer t;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    t = new Timer(Duration(seconds: 4), handleTimeout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "أرقام",
              style: TextStyle(
                  fontFamily: "MainLogoFont",
                  color: Colors.white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                  decorationStyle: TextDecorationStyle.solid),
            ),
            SpinKitThreeBounce(
              color: Colors.white,
              size: 60,
              duration: Duration(seconds: 2),
            )
          ],
        ),
      ),
    );
  }

  void handleTimeout() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return HomeScreen();
        },
        transitionsBuilder: (context, animation1, animation2, child) {
          return FadeTransition(
            opacity: animation1,
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 1000),
      ),
    );
  }
}
