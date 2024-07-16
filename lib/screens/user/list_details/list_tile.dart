import 'package:detail_dex/screens/user/bloc/details_bloc.dart';
import 'package:detail_dex/screens/user/view_details/view_details.dart';
import 'package:detail_dex/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:detail_dex/screens/user/search/search.dart';
import 'package:detail_dex/widgets/pick_location/location_take.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

listTile(
    {required Size size,
    required data,
    required BuildContext context,
    required DetailsBloc bloc,
    required bool issearch}) {
  return GestureDetector(
    onTap: () {
      if (focusNodeSearch.hasFocus) {
        focusNodeSearch.unfocus();
      }
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => ViewDetails(data: data)));
    },
    child: Padding(
        padding:
            EdgeInsets.only(top: size.width / 100, bottom: size.width / 100),
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
                                  data['location']['long'], context);
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
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.location_on,
                                  size: size.width / 12,
                                  color: const Color.fromARGB(255, 255, 0, 0),
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
                            padding: EdgeInsets.only(
                                top: size.width / 60, left: size.width / 69),
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
                            padding: EdgeInsets.only(
                                top: size.width / 70, left: size.width / 69),
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
                    padding: EdgeInsets.only(right: size.width / 100),
                    child: IconButton(
                        onPressed: () {
                          if (focusNodeSearch.hasFocus) {
                            focusNodeSearch.unfocus();
                          }

                          openBottomSheet(
                              context, data['id'], data, size, bloc, false);
                        },
                        icon: const Icon(Icons.more_vert_outlined)),
                  )
              ],
            ))),
  );
}
