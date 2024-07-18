import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

datepicker({required BuildContext context, required Size size}) async {
  return showMonthPicker(
    backgroundColor: Colors.white,
    headerColor: const Color.fromARGB(255, 35, 34, 34),
    context: context,
    unselectedMonthTextColor: Colors.black,
    cancelWidget: Text(
      'Cancel',
      style: TextStyle(
        fontFamily: 'dexb',
        color: Colors.black,
        fontSize: size.width / 28,
      ),
    ),
    confirmWidget: Text(
      'Ok',
      style: TextStyle(
        fontFamily: 'dexb',
        color: Colors.black,
        fontSize: size.width / 28,
      ),
    ),
    initialDate: DateTime.now(),
  );
}

Stream<List<Map<String, dynamic>>> todayExicutiveClientsdatas(
    String exicutive) async* {
  DateTime today = DateTime.now();
  DateTime todayDate = DateTime(today.year, today.month, today.day);
  try {
    final messagesSnapshot = FirebaseFirestore.instance
        .collection('Details')
        .orderBy('datetime', descending: true)
        .snapshots(includeMetadataChanges: true);

    await for (final messages in messagesSnapshot) {
      List<Map<String, dynamic>> todaygot = [];
      final detailslist = messages.docs.map((e) {
        Map<String, dynamic> data = e.data();
        data['id'] = e.id;

        return data;
      }).toList();
      for (var i in detailslist) {
        Timestamp timestamp = i['datetime'];
        DateTime datadate = timestamp.toDate();
        DateTime databasedate =
            DateTime(datadate.year, datadate.month, datadate.day);
        if (i['exicutiveid'] == exicutive && databasedate == todayDate) {
          todaygot.add(i);
        }
      }
      yield todaygot;
    }
  } catch (e) {
    log('Error fetching details: $e');
    yield [];
  }
}

Stream<List<Map<String, dynamic>>> exicutiveClientsdatas(
    String exicutive) async* {
  try {
    final messagesSnapshot = FirebaseFirestore.instance
        .collection('Details')
        .orderBy('datetime', descending: true)
        .snapshots(includeMetadataChanges: true);

    await for (final messages in messagesSnapshot) {
      List<Map<String, dynamic>> todaygot = [];
      final detailslist = messages.docs.map((e) {
        Map<String, dynamic> data = e.data();
        data['id'] = e.id;
        return data;
      }).toList();
      for (var i in detailslist) {
        if (i['exicutiveid'] == exicutive) {
          todaygot.add(i);
        }
      }
      yield todaygot;
    }
  } catch (e) {
    log('Error fetching details: $e');
    yield [];
  }
}

Stream<int> countTotalExicutiveClients(String exicutive) async* {
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
        if (i['exicutiveid'] == exicutive) {
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

datafilter(List details, DateTime datetime) {
  List result = [];
  DateTime date = DateTime(datetime.year, datetime.month, datetime.day);
  for (var i in details) {
    Timestamp timestamp = i['datetime'];
    DateTime datadate = timestamp.toDate();

    if (datadate.month == date.month && datadate.year == date.year) {
      result.add(i);
    }
  }
  return result;
}
