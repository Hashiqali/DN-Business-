import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detail_dex/screens/admin/bloc/admin_bloc.dart';
import 'package:detail_dex/widgets/snackbar_widget/snackbar.dart';
import 'package:flutter/material.dart';

addexicutives(
    {required TextEditingController aadexnamecontroller,
    required TextEditingController addexmobilercontroller,
    required TextEditingController addexpasswordcontroller,
    required GlobalKey<FormState> addexkey,
    required FocusNode focusNodeaddex1,
    required FocusNode focusNodeaddex2,
    required FocusNode focusNodeaddex3,
    required bool isedit,
    required String id,
    required BuildContext context,
    required AdminBloc bloc}) async {
  final CollectionReference firedata =
      FirebaseFirestore.instance.collection('Exicutives');
  if (addexkey.currentState!.validate()) {
    focusNodeaddex1.unfocus();
    focusNodeaddex2.unfocus();
    focusNodeaddex3.unfocus();
    bloc.add(AddExicutiveLoading());
    final data = {
      'name': aadexnamecontroller.text.trim(),
      'number': addexmobilercontroller.text.trim(),
      'password': addexpasswordcontroller.text.trim()
    };
    try {
      if (isedit) {
        await firedata.doc(id).update(data);
      } else {
        await firedata.add(data);
      }

      snackbarSucess(context, 'Executive added successfully!');
      Navigator.pop(context);
    } catch (e) {
      snackbarAlert(context, 'Failed to add executive. Please try again.');
    }
  } else {
    snackbarAlert(context, 'Please fill in all fields correctly.');
  }
}
