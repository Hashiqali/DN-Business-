import 'package:detail_dex/screens/admin/home_screen/home_screen.dart';
import 'package:detail_dex/screens/user/bloc/details_bloc.dart';
import 'package:detail_dex/widgets/snackbar_widget/snackbar.dart';
import 'package:flutter/material.dart';

login(
    {required GlobalKey<FormState> loginkey,
    required TextEditingController usercontroller,
    required TextEditingController passwordcontroller,
    required DetailsBloc loginbloc,
    required FocusNode focusNodelogin1,
    required FocusNode focusNodelogin2,
    required BuildContext context}) async {
  if (loginkey.currentState!.validate()) {
    focusNodelogin1.unfocus();
    focusNodelogin2.unfocus();
    loginbloc.add(LoginLoadingEvent(istrue: false));
    if (usercontroller.text.trim() == 'admin' &&
        passwordcontroller.text.trim() == '12345') {
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const HomeScreenAdmin()));
    } else {
      snackbarAlert(context, 'Invalid username and password');
    }
  } else {
    snackbarAlert(context, 'Please enter valid username and password');
  }
}
