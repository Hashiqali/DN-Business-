import 'package:detail_dex/screens/user/splash/functions.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

String exicutivename = "";
String exicutiveNumber = "";
String exicutiveId = "";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splashtime(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                FadeAnimatedText(
                  'DN Business',
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'dex2',
                    fontSize: 40,
                  ),
                  duration: const Duration(milliseconds: 5000),
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ],
        ),
      ),
    );
  }
}
