import 'package:detail_dex/screens/list_details/bottom_sheet.dart';
import 'package:detail_dex/screens/search/search.dart';
import 'package:detail_dex/widgets/pick_location/location_take.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

listTile(
    {required Size size,
    required data,
    required BuildContext context,
    required bool issearch}) {
  return Padding(
      padding: EdgeInsets.only(top: size.width / 100, bottom: size.width / 100),
      child: Container(
          height: size.height / 8,
          width: size.width / 3,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                width: size.width / 2.8,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: FlutterMap(
                      options: MapOptions(
                          onTap: (tapPosition, point) {
                            if (focusNodeSearch.hasFocus) {
                              focusNodeSearch.unfocus();
                            }
                            checkLocationPermission(data['location']['lat'],
                                data['location']['long']);
                          },
                          initialZoom: 14.5,
                          initialCenter: LatLng(data['location']['lat'],
                              data['location']['long']),
                          interactionOptions: const InteractionOptions(
                              flags: ~InteractiveFlag.doubleTapDragZoom)),
                      children: [
                        openmap,
                        MarkerLayer(markers: [
                          Marker(
                              point: LatLng(data['location']['lat'],
                                  data['location']['long']),
                              width: 60,
                              height: 60,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.location_on,
                                size: 35,
                                color: Color.fromARGB(255, 255, 0, 0),
                              ))
                        ])
                      ]),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: SizedBox(
                            width: size.width / 2.3,
                            height: size.height / 36,
                            child: Text(
                              maxLines: 1,
                              'Name : ${data['name']}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: 'dexb',
                                  fontSize: size.width / 25,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 10),
                          child: Text(
                            'Phone : ${data['number']}',
                            style: TextStyle(
                                fontFamily: 'dexb',
                                fontSize: size.width / 25,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!issearch)
                Padding(
                  padding: EdgeInsets.only(right: size.width / 98),
                  child: IconButton(
                      onPressed: () {
                        if (focusNodeSearch.hasFocus) {
                          focusNodeSearch.unfocus();
                        }

                        openBottomSheet(context, data['id'], data, size);
                      },
                      icon: const Icon(Icons.more_vert_outlined)),
                )
            ],
          )));
}
