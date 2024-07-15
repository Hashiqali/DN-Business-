import 'package:connectivity/connectivity.dart';
import 'package:detail_dex/screens/user/add_details/add_edit_details.dart';
import 'package:detail_dex/screens/user/bloc/details_bloc.dart';
import 'package:detail_dex/screens/user/list_details/functions.dart';
import 'package:detail_dex/widgets/no_network_widget/no_network_widget.dart';
import 'package:flutter/material.dart';

void openBottomSheet(BuildContext context, id, Map<String, dynamic> data, size,
    DetailsBloc bloc) async {
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
                    Icons.edit,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Edit',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'dex2',
                        fontSize: size.width / 30,
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => AddDetails(
                                  editdata: data,
                                  isedit: true,
                                )));
                  },
                ),
                ListTile(
                    leading: Icon(
                      size: size.width / 17,
                      Icons.delete,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Delete',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'dex2',
                          fontSize: size.width / 30,
                          fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      alertDelete(
                          context: context, size: size, id: id, bloc: bloc);
                    }),
                ListTile(
                  leading: Icon(
                    size: size.width / 17,
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'dex2',
                        fontSize: size.width / 30,
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

alertDelete({required context, required size, required id, required bloc}) {
  return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: const Color.fromARGB(255, 22, 22, 22),
          content: Text(
            'Are you sure you want to delete ?',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'dex2',
                fontSize: size.width / 30,
                fontWeight: FontWeight.w400),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  deletedetails(id, context, bloc);
                },
                child: Text(
                  'Yes',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'dex2',
                      fontSize: size.width / 28,
                      fontWeight: FontWeight.w400),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'No',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'dex2',
                      fontSize: size.width / 28,
                      fontWeight: FontWeight.w400),
                )),
          ],
          actionsPadding: const EdgeInsets.all(10),
        );
      });
}
