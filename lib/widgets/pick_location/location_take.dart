import 'package:connectivity/connectivity.dart';
import 'package:detail_dex/screens/user/add_details/functions.dart';
import 'package:detail_dex/screens/user/bloc/details_bloc.dart';
import 'package:detail_dex/widgets/no_network_widget/no_network_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Location extends StatefulWidget {
  const Location({
    super.key,
    required this.bloc,
  });
  final DetailsBloc bloc;

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  late Future<LatLong> _locationFuture;

  @override
  void initState() {
    super.initState();
    _locationFuture = _currentLocationTake();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<LatLong>(
        future: _locationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (snapshot.hasData) {
            return FlutterLocationPicker(
              loadingWidget: const CircularProgressIndicator(
                color: Colors.black,
              ),
              initPosition: snapshot.data!,
              locationButtonsColor: Colors.white,
              locationButtonBackgroundColor: Colors.black,
              zoomButtonsBackgroundColor: Colors.black,
              zoomButtonsColor: Colors.white,
              mapLoadingBackgroundColor: Colors.black,
              trackMyPosition: false,
              selectLocationButtonStyle: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              selectedLocationButtonTextstyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'dex1',
              ),
              selectLocationButtonText: 'Pick Location',
              initZoom: 11,
              minZoomLevel: 5,
              maxZoomLevel: 16,
              markerIcon: Icon(
                Icons.location_on,
                size: size.width / 9,
                color: const Color.fromARGB(255, 255, 0, 0),
              ),
              onPicked: (pickedData) {
                final data = {
                  'lat': pickedData.latLong.latitude,
                  'long': pickedData.latLong.longitude,
                };
                location = data;
                address = pickedData.addressData;
                widget.bloc.add(LocationBuilder());
                Navigator.pop(context);
              },
            );
          } else {
            return const Center(
              child: Text(
                'Failed to get location',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }

  Future<LatLong> _currentLocationTake() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      forceAndroidLocationManager: true,
    );
    return LatLong(position.latitude, position.longitude);
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
    } else if (locationStatus.isDenied || locationStatus.isPermanentlyDenied) {
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
