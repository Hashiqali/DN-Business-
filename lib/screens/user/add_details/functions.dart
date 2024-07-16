import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detail_dex/screens/user/bloc/details_bloc.dart';
import 'package:detail_dex/screens/user/splash/splash.dart';
import 'package:detail_dex/widgets/pick_location/location_take.dart';
import 'package:detail_dex/widgets/snackbar_widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:permission_handler/permission_handler.dart';

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

locationPick({required BuildContext context, required bloc}) async {
  PermissionStatus locationStatus = await Permission.location.request();
  if (locationStatus.isGranted) {
    final latlong = await getLocation();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => Location(
              latlng: LatLong(34, 42),
              bloc: bloc,
            )));
  } else if (locationStatus.isDenied) {
  } else if (locationStatus.isPermanentlyDenied) {
    openAppSettings();
  }
}
