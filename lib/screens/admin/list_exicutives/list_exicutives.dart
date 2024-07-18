import 'package:detail_dex/screens/admin/admin_clientlist/admin_clientlist.dart';
import 'package:detail_dex/screens/admin/bloc/admin_bloc.dart';
import 'package:detail_dex/screens/admin/list_exicutives/functions.dart';
import 'package:detail_dex/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:detail_dex/widgets/loading_screen/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListExicutives extends StatelessWidget {
  ListExicutives({super.key});
  final AdminBloc adminbloc = AdminBloc();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Executives',
          style: TextStyle(
            fontFamily: 'dex2',
            color: Colors.white,
            fontSize: size.width / 20,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width / 70),
        child: StreamBuilder<List>(
            stream: getexicutiveDetails(),
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
                details.sort((a, b) =>
                    a['name'].toLowerCase().compareTo(b['name'].toLowerCase()));
                return BlocBuilder<AdminBloc, AdminState>(
                  bloc: adminbloc,
                  builder: (context, state) {
                    if (state is AdminDeleteLoadingState) {
                      return const LoadingScreen();
                    }
                    return ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: size.width / 50,
                          );
                        },
                        padding: EdgeInsets.all(size.width / 40),
                        itemCount: details.length,
                        itemBuilder: (ctx, index) {
                          final data = details[index];

                          return GestureDetector(
                              onLongPress: () {
                                openBottomSheet(context, data['id'], data, size,
                                    adminbloc, true);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 24, 24, 24),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (ctx) => AdminClientList(
                                                    exicutive: data['id'],
                                                  )));
                                    },
                                    leading: GestureDetector(
                                      onLongPress: () {
                                        alertPassshow(
                                          size: size,
                                          context: context,
                                          password: data['password'],
                                        );
                                      },
                                      child: CircleAvatar(
                                        backgroundImage: const AssetImage(
                                            'assets/images/user.png'),
                                        radius: size.width / 15,
                                      ),
                                    ),
                                    title: Text(
                                      data['name'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'dexb',
                                        fontSize: size.width / 25,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    subtitle: Text(
                                      data['number'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'dex1',
                                        fontSize: size.width / 38,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    trailing: StreamBuilder(
                                        stream: countTodayExicutiveClients(
                                            data['id']),
                                        builder: (context, snapshot) {
                                          int count = 0;
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            count = 0;
                                          } else {
                                            count = snapshot.data ?? 0;
                                          }
                                          return CircleAvatar(
                                              backgroundColor: Colors.green,
                                              radius: size.width / 30,
                                              child: Text(
                                                '$count',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'dexb',
                                                  fontSize: size.width / 34,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ));
                                        }),
                                  )));
                        });
                  },
                );
              }
            }),
      ),
    );
  }
}
