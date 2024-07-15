import 'package:connectivity/connectivity.dart';
import 'package:detail_dex/screens/user/add_details/functions.dart';
import 'package:detail_dex/screens/user/bloc/details_bloc.dart';
import 'package:detail_dex/widgets/no_network_widget/no_network_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Location extends StatelessWidget {
  const Location({super.key, required this.bloc});
  final DetailsBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: OpenStreetMapSearchAndPick(
            buttonWidth: 130,
            zoomInIcon: Icons.zoom_in_sharp,
            zoomOutIcon: Icons.zoom_out,
            locationPinIconColor: const Color.fromARGB(255, 255, 0, 0),
            locationPinTextStyle: const TextStyle(
                color: Colors.black, fontSize: 12, fontFamily: 'dex1'),
            buttonColor: Colors.black,
            buttonText: 'Pick Location',
            buttonTextStyle: const TextStyle(
                color: Colors.white, fontSize: 12, fontFamily: 'dex1'),
            onPicked: (pickedData) {
              final data = {
                'lat': pickedData.latLong.latitude,
                'long': pickedData.latLong.longitude
              };
              location = data;
              address = pickedData.address;
              bloc.add(LocationBuilder());
              Navigator.pop(context);
            }));
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

TileLayer get openmap => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );

Future<void> openGoogleMaps(double lat, double lng) async {
  final googleMapsUrl =
      Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");

  await launchUrl(googleMapsUrl);
}
