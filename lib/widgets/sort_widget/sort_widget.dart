import 'package:connectivity/connectivity.dart';
import 'package:detail_dex/screens/user/bloc/details_bloc.dart';
import 'package:detail_dex/screens/user/home_screen/functions.dart';
import 'package:detail_dex/screens/user/list_details/list_details.dart';
import 'package:detail_dex/screens/user/search/search.dart';
import 'package:detail_dex/widgets/no_network_widget/no_network_widget.dart';
import 'package:flutter/material.dart';

void sortdetails(BuildContext context, Size size) async {
  if (focusNodeSearch.hasFocus) {
    focusNodeSearch.unfocus();
  }
  final connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => const NoNetworkWidget(
              isSplash: false,
            )));
  } else {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            color: const Color.fromARGB(255, 31, 30, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    size: size.width / 17,
                    Icons.person_pin_circle_sharp,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Sort by my clients',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'dex2',
                        fontSize: size.width / 30,
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () {
                    homebloc.add(FilteredDetails(details: sortbymyclients()));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                    leading: Icon(
                      size: size.width / 17,
                      Icons.person_pin_circle_sharp,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Sort by all clients',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'dex2',
                          fontSize: size.width / 30,
                          fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      homebloc.add(AllDetails());
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
