import 'package:detail_dex/widgets/pick_location/location_take.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

viewTileWidget(
    {required Size size,
    required TextEditingController namecontroller,
    required TextEditingController phonecontroller,
    required TextEditingController notecontroller,
    required Map<String, dynamic> data,
    required BuildContext context}) {
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(size.width / 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: size.width / 26,
              bottom: size.width / 26,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              height: size.height / 5,
              width: size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FlutterMap(
                  options: MapOptions(
                    onTap: (tapPosition, point) {
                      checkLocationPermission(
                        data['location']['lat'],
                        data['location']['long'],
                        context,
                      );
                    },
                    initialZoom: 14.5,
                    initialCenter: LatLng(
                      data['location']['lat'],
                      data['location']['long'],
                    ),
                    interactionOptions: const InteractionOptions(
                      flags: ~InteractiveFlag.doubleTapDragZoom,
                    ),
                  ),
                  children: [
                    openmap,
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                            data['location']['lat'],
                            data['location']['long'],
                          ),
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.location_on,
                            size: 35,
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size.width / 25),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: size.width / 20,
                ),
                Text(
                  '${data['address']['suburb'] ?? data['address']['village'] ?? data['address']['town']}, ${data['address']['state_district']}, ${data['address']['state']}',
                  style: TextStyle(
                    fontFamily: 'dex2',
                    color: Colors.white,
                    fontSize: size.width / 30,
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: TextStyle(
              fontFamily: 'dex1',
              color: Colors.white,
              fontSize: size.width / 24,
            ),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'Name',
              labelStyle: TextStyle(
                fontFamily: 'dex1',
                color: Colors.white,
                fontSize: size.width / 25,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            controller: namecontroller,
            keyboardType: TextInputType.text,
            enabled: false,
          ),
          SizedBox(
            height: size.height / 70,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: TextStyle(
              fontFamily: 'dex1',
              color: Colors.white,
              fontSize: size.width / 24,
            ),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'Phone Number',
              labelStyle: TextStyle(
                fontFamily: 'dex1',
                color: Colors.white,
                fontSize: size.width / 25,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            controller: phonecontroller,
            keyboardType: TextInputType.number,
            enabled: false,
          ),
          SizedBox(
            height: size.height / 70,
          ),
          TextFormField(
            enabled: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: TextStyle(
              fontFamily: 'dex1',
              color: Colors.white,
              fontSize: size.width / 24,
            ),
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'Note',
              labelStyle: TextStyle(
                fontFamily: 'dex1',
                color: Colors.white,
                fontSize: size.width / 25,
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            keyboardType: TextInputType.text,
            minLines: null,
            maxLines: null,
            controller: notecontroller,
          ),
        ],
      ),
    ),
  );
}
