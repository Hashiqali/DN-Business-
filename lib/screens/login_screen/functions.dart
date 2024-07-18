import 'package:connectivity/connectivity.dart';
import 'package:detail_dex/firebase/functions.dart';
import 'package:detail_dex/screens/admin/home_screen/home_screen.dart';
import 'package:detail_dex/screens/user/bloc/details_bloc.dart';
import 'package:detail_dex/screens/user/home_screen/home_screen.dart';
import 'package:detail_dex/screens/user/splash/functions.dart';
import 'package:detail_dex/widgets/no_network_widget/no_network_widget.dart';
import 'package:detail_dex/widgets/snackbar_widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

login(
    {required GlobalKey<FormState> loginkey,
    required TextEditingController usercontroller,
    required TextEditingController passwordcontroller,
    required DetailsBloc loginbloc,
    required FocusNode focusNodelogin1,
    required FocusNode focusNodelogin2,
    required BuildContext context}) async {
  final connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => const NoNetworkWidget(
              isSplash: false,
            )));
  } else {
    if (loginkey.currentState!.validate()) {
      focusNodelogin1.unfocus();
      focusNodelogin2.unfocus();
      loginbloc.add(LoginLoadingEvent(istrue: false));

      if (usercontroller.text.trim() == 'admin' &&
          passwordcontroller.text.trim() == '12345') {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.of(context).pushAndRemoveUntil(
            (MaterialPageRoute(builder: (ctx) => const HomeScreenAdmin())),
            (route) => false);
        addadminShared();
        usercontroller.text = '';
        passwordcontroller.text = '';
      } else {
        final exivutives = await getAllExicutives();
        final passwordCorrect = exivutives.any((element) =>
            element['name'] == usercontroller.text.trim() &&
            element['password'] == passwordcontroller.text.trim());

        if (passwordCorrect) {
          Navigator.of(context).pushAndRemoveUntil(
              (MaterialPageRoute(builder: (ctx) => HomeScreen())),
              (route) => false);
          snackbarSucess(context, 'Login successful!');
          final exicutiveData = exivutives.firstWhere((element) =>
              element['name'] == usercontroller.text.trim() &&
              element['password'] == passwordcontroller.text.trim());
          addShared(exicutivedata: exicutiveData);
          usercontroller.text = '';
          passwordcontroller.text = '';
        } else {
          snackbarAlert(context, 'Invalid username and password');
        }
      }
    } else {
      snackbarAlert(context, 'Please enter valid username and password');
    }
  }
}

addShared({required exicutivedata}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('exicutive', true);
  await prefs.setString('name', exicutivedata['name']);
  await prefs.setString('number', exicutivedata['number']);
  await prefs.setString('id', exicutivedata['id']);
  saveExicutive();
}

addadminShared() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('admin', true);
}
