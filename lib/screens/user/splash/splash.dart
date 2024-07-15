import 'package:connectivity/connectivity.dart';
import 'package:detail_dex/screens/user/home_screeen/home_screen.dart';
import 'package:detail_dex/screens/login_screen/login_screen.dart';
import 'package:detail_dex/widgets/no_network_widget/no_network_widget.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splashtime();
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
                  'DETAILDEX',
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

  splashtime() async {
    await Future.delayed(const Duration(milliseconds: 5000));
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => const NoNetworkWidget(
                isSplash: true,
              )));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => LoginScreen()));
    }
  }
}
