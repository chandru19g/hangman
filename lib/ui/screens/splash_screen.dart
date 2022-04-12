import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hangman/routes/routes.dart';
import 'package:hangman/ui/themes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed(RouteManager.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  "assets/images/gallow.png",
                  height: height * 0.49,
                ),
              ),
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'HANGMAN',
                    textStyle:
                        headerTextStyle.copyWith(fontWeight: FontWeight.bold),
                    colors: [
                      Colors.purple,
                      Colors.blue,
                      Colors.yellow,
                      Colors.red,
                    ],
                    speed: const Duration(seconds: 1),
                  ),
                ],
                isRepeatingAnimation: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
