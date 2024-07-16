import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

snackbarSucess(context, String messege) {
  IconSnackBar.show(context,
      duration: const Duration(seconds: 2),
      snackBarStyle:
          const SnackBarStyle(labelTextStyle: TextStyle(fontFamily: 'dex2')),
      snackBarType: SnackBarType.success,
      label: messege);
}

snackbarFail(context, String messege) {
  IconSnackBar.show(context,
      duration: const Duration(seconds: 2),
      snackBarType: SnackBarType.fail,
      snackBarStyle:
          const SnackBarStyle(labelTextStyle: TextStyle(fontFamily: 'dex2')),
      label: messege);
}

snackbarAlert(context, String messege) {
  IconSnackBar.show(context,
      duration: const Duration(seconds: 2),
      snackBarStyle:
          const SnackBarStyle(labelTextStyle: TextStyle(fontFamily: 'dex2')),
      snackBarType: SnackBarType.alert,
      label: messege);
}
