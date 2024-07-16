import 'package:connectivity/connectivity.dart';
import 'package:detail_dex/screens/login_screen/login_screen.dart';
import 'package:detail_dex/screens/user/home_screen/home_screen.dart';
import 'package:detail_dex/screens/user/splash/splash.dart';
import 'package:detail_dex/widgets/no_network_widget/no_network_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

splashtime({required BuildContext context}) async {
  await Future.delayed(const Duration(milliseconds: 5000));
  final connectivityResult = await Connectivity().checkConnectivity();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? includeexicutive = prefs.getBool('exicutive');
  if (connectivityResult == ConnectivityResult.none) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => const NoNetworkWidget(
              isSplash: true,
            )));
  } else if (includeexicutive != null) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
    saveExicutiveFromSplash(prefs);
  } else {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => LoginScreen()));
  }
}

saveExicutive() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  exicutiveId = prefs.getString('id')!;
  exicutivename = prefs.getString('name')!;
  exicutiveNumber = prefs.getString('number')!;
}

saveExicutiveFromSplash(SharedPreferences prefs) async {
  exicutiveId = prefs.getString('id')!;
  exicutivename = prefs.getString('name')!;
  exicutiveNumber = prefs.getString('number')!;
}
