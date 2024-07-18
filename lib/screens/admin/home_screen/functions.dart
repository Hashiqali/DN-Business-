import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detail_dex/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Stream<int> countTodayClients() async* {
  DateTime today = DateTime.now();
  DateTime todayDate = DateTime(today.year, today.month, today.day);
  try {
    final messagesSnapshot = FirebaseFirestore.instance
        .collection('Details')
        .orderBy('datetime', descending: true)
        .snapshots(includeMetadataChanges: true);

    await for (final messages in messagesSnapshot) {
      List todaygot = [];
      final detailslist = messages.docs.map((e) {
        Map<String, dynamic> data = e.data();

        return data;
      }).toList();
      for (var i in detailslist) {
        Timestamp timestamp = i['datetime'];
        DateTime datadate = timestamp.toDate();
        DateTime databasedate =
            DateTime(datadate.year, datadate.month, datadate.day);
        if (databasedate == todayDate) {
          todaygot.add(i);
        }
      }
      yield todaygot.length;
    }
  } catch (e) {
    log('Error fetching details: $e');
    yield 0;
  }
}

Stream<int> countTotalClients() async* {
  try {
    final messagesSnapshot = FirebaseFirestore.instance
        .collection('Details')
        .orderBy('datetime', descending: true)
        .snapshots(includeMetadataChanges: true);

    await for (final messages in messagesSnapshot) {
      final detailslist = messages.docs.map((e) {
        Map<String, dynamic> data = e.data();

        return data;
      }).toList();

      yield detailslist.length;
    }
  } catch (e) {
    log('Error fetching details: $e');
    yield 0;
  }
}

alertadminLogout({
  required context,
  required size,
}) {
  return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: const Color.fromARGB(255, 22, 22, 22),
          content: Text(
            'Are you sure you want to logout ?',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'dex2',
                fontSize: size.width / 30,
                fontWeight: FontWeight.w400),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  logoutadmin(context: context);
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

logoutadmin({required BuildContext context}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('admin');
  Navigator.of(context).pushAndRemoveUntil(
      (MaterialPageRoute(builder: (ctx) => LoginScreen())), (route) => false);
}
