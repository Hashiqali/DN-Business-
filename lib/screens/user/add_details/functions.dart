import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detail_dex/screens/user/bloc/details_bloc.dart';
import 'package:detail_dex/widgets/snackbar_widget/snackbar.dart';
import 'package:flutter/material.dart';

final CollectionReference firedata =
    FirebaseFirestore.instance.collection('Details');
Map<String, dynamic> address = {};
Map<String, dynamic> location = {};

submit(
    {required BuildContext context,
    required TextEditingController namecontroller,
    required TextEditingController numbercontroller,
    required TextEditingController notecontroller,
    required key,
    required id,
    required DetailsBloc bloc,
    required bool isedit}) async {
  if (key.currentState!.validate() && location.isNotEmpty) {
    bloc.add(LoadingBuilder());
    final data = {
      'createdAt': DateTime.now(),
      'name': namecontroller.text.trim(),
      'number': numbercontroller.text.trim(),
      'note': notecontroller.text.trim(),
      'location': location,
      'address': address
    };
    if (isedit) {
      await firedata.doc(id).update(data);
    } else {
      await firedata.add(data);
    }

    await Future.delayed(const Duration(seconds: 1));
    snackbarSucess(context, 'Submission successful');
    Navigator.pop(context);
    namecontroller.clear();
    numbercontroller.clear();
    notecontroller.clear();
    location.clear();
    address.clear();
  } else {
    if (location.isEmpty && key.currentState!.validate()) {
      snackbarFail(context, 'Please provide a valid location');
    } else {
      snackbarFail(context, 'Please fill all fields');
    }
  }
}
