import 'package:detail_dex/screens/admin/admin_clientlist/functions.dart';
import 'package:detail_dex/screens/user/list_details/list_details.dart';
import 'package:detail_dex/screens/user/list_details/list_tile.dart';
import 'package:flutter/material.dart';

class TodayClients extends StatelessWidget {
  const TodayClients({super.key, required this.exixutive});
  final String exixutive;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: StreamBuilder(
            stream: todayExicutiveClientsdatas(exixutive),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(
                      fontFamily: 'dex2',
                      color: Colors.white,
                      fontSize: size.width / 25,
                      fontWeight: FontWeight.w400),
                ));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 255, 255, 255),
                ));
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return Center(
                    child: Text(
                  'No data available',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'dex2',
                      fontSize: size.width / 25,
                      fontWeight: FontWeight.w400),
                ));
              } else {
                List details = snapshot.data ?? [];
                return ListView.builder(
                    padding: EdgeInsets.only(top: size.width / 100),
                    itemCount: details.length,
                    itemBuilder: (ctx, index) {
                      final data = details[index];

                      return listTile(
                          bloc: homebloc,
                          issearch: false,
                          size: size,
                          data: data,
                          context: context);
                    });
              }
            }));
  }
}
