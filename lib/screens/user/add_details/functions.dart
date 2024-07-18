import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detail_dex/screens/user/bloc/details_bloc.dart';
import 'package:detail_dex/screens/user/splash/splash.dart';
import 'package:detail_dex/widgets/pick_location/location_take.dart';
import 'package:detail_dex/widgets/snackbar_widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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

    if (isedit) {
      final data = {
        'name': namecontroller.text.trim(),
        'number': numbercontroller.text.trim(),
        'note': notecontroller.text.trim(),
        'location': location,
        'address': address
      };
      await firedata.doc(id).update(data);
    } else {
      final data = {
        'exicutiveid': exicutiveId,
        'datetime': DateTime.now(),
        'name': namecontroller.text.trim(),
        'number': numbercontroller.text.trim(),
        'note': notecontroller.text.trim(),
        'location': location,
        'address': address
      };
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

Future<void> locationPick({
  required BuildContext context,
  required DetailsBloc bloc,
}) async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => Location(
            bloc: bloc,
          )));
}
