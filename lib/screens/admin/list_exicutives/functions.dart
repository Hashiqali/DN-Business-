import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detail_dex/screens/admin/bloc/admin_bloc.dart';
import 'package:detail_dex/widgets/snackbar_widget/snackbar.dart';
import 'package:flutter/material.dart';

Stream<List<Map<String, dynamic>>> getexicutiveDetails() async* {
  try {
    final messagesSnapshot = FirebaseFirestore.instance
        .collection('Exicutives')
        .orderBy('name', descending: false)
        .snapshots(includeMetadataChanges: true);

    await for (final messages in messagesSnapshot) {
      final messagesList = messages.docs.map((e) {
        Map<String, dynamic> data = e.data();
        data['id'] = e.id;
        return data;
      }).toList();

      yield messagesList;
    }
  } catch (e) {
    log('Error fetching details: $e');
    yield [];
  }
}

alertPassshow(
    {required Size size,
    required BuildContext context,
    required String password}) {
  return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: const Color.fromARGB(255, 22, 22, 22),
          content: SelectableText(
            password,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'dex2',
              fontSize: size.width / 15,
              fontWeight: FontWeight.w400,
            ),
            showCursor: true,
            cursorColor: Colors.white,
            cursorWidth: 2.0,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Back',
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

deleteExicutivedetails(String id, context, bloc) async {
  Navigator.pop(context);
  bloc.add(AdminDeleteLoading());
  final CollectionReference firedata =
      FirebaseFirestore.instance.collection('Exicutives');

  await firedata.doc(id).delete();
  Navigator.pop(context);

  snackbarSucess(context, 'Deleted successfully');
}
