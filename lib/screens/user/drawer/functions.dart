import 'package:detail_dex/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

alertLogout({
  required context,
  required size,
}) {
  return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: const Color.fromARGB(255, 22, 22, 22),
          content: Text(
            'Are you sure you want to logout ?',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'dex2',
                fontSize: size.width / 30,
                fontWeight: FontWeight.w400),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  logout(context: context);
                },
                child: Text(
                  'Yes',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'dex2',
                      fontSize: size.width / 28,
                      fontWeight: FontWeight.w400),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'No',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'dex2',
                      fontSize: size.width / 28,
                      fontWeight: FontWeight.w400),
                )),
          ],
          actionsPadding: const EdgeInsets.all(10),
        );
      });
}

logout({required BuildContext context}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('exicutive');
  Navigator.of(context).pushAndRemoveUntil(
      (MaterialPageRoute(builder: (ctx) => LoginScreen())), (route) => false);
}
