import 'package:cloud_firestore/cloud_firestore.dart';

Future<List> getAllExicutives() async {
  final CollectionReference firedata =
      FirebaseFirestore.instance.collection('Exicutives');

  QuerySnapshot querySnapshot = await firedata.get();

  List<Map<String, dynamic>> dataList = [];

  for (var doc in querySnapshot.docs) {
    if (doc.exists) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        data['id'] = doc.id;
        dataList.add(data);
      }
    }
  }

  return dataList;
}

