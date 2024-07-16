import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:detail_dex/screens/user/add_details/functions.dart';
import 'package:detail_dex/screens/user/bloc/details_bloc.dart';
import 'package:detail_dex/widgets/no_network_widget/no_network_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:location_plus/location_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Location extends StatelessWidget {
  const Location({super.key, required this.bloc, required this.latlng});
  final DetailsBloc bloc;
  final LatLong latlng;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FlutterLocationPicker(
          selectLocationButtonStyle: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          selectedLocationButtonTextstyle: const TextStyle(fontSize: 18),
          selectLocationButtonText: 'Set Current Location',
          selectLocationButtonLeadingIcon: const Icon(Icons.check),
          initZoom: 11,
          minZoomLevel: 5,
          maxZoomLevel: 16,
          trackMyPosition: false,
          onError: (e) => print(e),
          onPicked: (pickedData) {
            final data = {
              'lat': pickedData.latLong.latitude,
              'long': pickedData.latLong.longitude
            };
            location = data;
            address = pickedData.addressData;
            bloc.add(LocationBuilder());
            Navigator.pop(context);
          },
        )

        // OpenStreetMapSearchAndPick(
        //     buttonWidth: 130,
        //     zoomInIcon: Icons.zoom_in_sharp,
        //     zoomOutIcon: Icons.zoom_out,
        //     locationPinIconColor: const Color.fromARGB(255, 255, 0, 0),
        //     locationPinTextStyle: const TextStyle(
        //         color: Colors.black, fontSize: 12, fontFamily: 'dex1'),
        //     buttonColor: Colors.black,
        //     buttonText: 'Pick Location',
        //     buttonTextStyle: const TextStyle(
        //         color: Colors.white, fontSize: 12, fontFamily: 'dex1'),
        //     onPicked: (pickedData) {
        //       final data = {
        //         'lat': pickedData.latLong.latitude,
        //         'long': pickedData.latLong.longitude
        //       };
        //       location = data;
        //       address = pickedData.address;
        //       bloc.add(LocationBuilder());
        //       Navigator.pop(context);
        //     })
        );
  }
}

void checkLocationPermission(
    double lat, double lng, BuildContext context) async {
  final connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => const NoNetworkWidget(
              isSplash: false,
            )));
  } else {
    PermissionStatus locationStatus = await Permission.location.request();
    if (locationStatus.isGranted) {
      openGoogleMaps(lat, lng);
    } else if (locationStatus.isDenied) {
    } else if (locationStatus.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

Future<LatLong> getLocation() async {
  LatLong result = const LatLong(12, 3);
  print('heyyyyyy');
  // var position = await LocationPlus.getCurrentLocation();
  // double _latitude = double.parse(position['latitude']);
  // double _longitude = double.parse(position['longitude']);

  LocationPermission permission = await Geolocator.checkPermission();

  permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.whileInUse) {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('poaition==  ${position.latitude} ');
  }

  // print(' lat  $_latitude ,long $_longitude');
  // result = LatLong(position.latitude, position.longitude);

  return result;
}

TileLayer get openmap => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );

Future<void> openGoogleMaps(double lat, double lng) async {
  final googleMapsUrl =
      Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");

  await launchUrl(googleMapsUrl);
}
