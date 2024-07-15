import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detail_dex/screens/user/bloc/details_bloc.dart';
import 'package:detail_dex/widgets/snackbar_widget/snackbar.dart';
import 'package:flutter/material.dart';

Stream<List<Map<String, dynamic>>> getDetails() async* {
  try {
    final messagesSnapshot = FirebaseFirestore.instance
        .collection('Details')
        .orderBy('createdAt', descending: true)
        .snapshots(includeMetadataChanges: true);

    await for (final messages in messagesSnapshot) {
      final messagesList = messages.docs.map((e) {
        Map<String, dynamic> data = e.data();
        data['id'] = e.id; // Add document ID to the data map
        return data;
      }).toList();

      yield messagesList;
    }
  } catch (e) {
    log('Error fetching details: $e');
    yield [];
  }
}

deletedetails(String id, context, DetailsBloc bloc) async {
  Navigator.pop(context);
  bloc.add(LoadingWidgetEvent(context: context, id: id));
  final CollectionReference firedata =
      FirebaseFirestore.instance.collection('Details');

  await firedata.doc(id).delete();
  Navigator.pop(context);

  snackbarSucess(context, 'Deleted successfully');
}
