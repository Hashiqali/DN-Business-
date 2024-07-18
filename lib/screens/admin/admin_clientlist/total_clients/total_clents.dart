import 'package:detail_dex/screens/admin/admin_clientlist/functions.dart';
import 'package:detail_dex/screens/admin/bloc/admin_bloc.dart';
import 'package:detail_dex/screens/user/list_details/list_details.dart';
import 'package:detail_dex/screens/user/list_details/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalClients extends StatelessWidget {
  TotalClients({super.key, required this.exixutive});
  final String exixutive;
  final AdminBloc bloc = AdminBloc();
  List alldatas = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: size.width / 50, bottom: size.width / 50),
            child: Row(
              children: [
                StreamBuilder(
                    stream: countTotalExicutiveClients(exixutive),
                    builder: (context, snapshot) {
                      int count = 0;
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        count = 0;
                      } else {
                        count = snapshot.data ?? 0;
                      }
                      return Text(
                        'Total Clients  $count',
                        style: TextStyle(
                          fontFamily: 'dexb',
                          color: Colors.white,
                          fontSize: size.width / 25,
                        ),
                      );
                    }),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final data = await datepicker(context: context, size: size);
              bloc.add(FilterDatas(datetime: data, details: alldatas));
            },
            child: Container(
              height: size.height / 15,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  'Filter month',
                  style: TextStyle(
                    fontFamily: 'dexb',
                    color: Colors.black,
                    fontSize: size.width / 30,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: exicutiveClientsdatas(exixutive),
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
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
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
                    alldatas = details;

                    return BlocBuilder<AdminBloc, AdminState>(
                      bloc: bloc,
                      builder: (context, state) {
                        if (state is FilterDatasState) {
                          return Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    padding:
                                        EdgeInsets.only(top: size.width / 100),
                                    itemCount: state.details.length,
                                    itemBuilder: (ctx, index) {
                                      final data = state.details[index];

                                      return listTile(
                                          bloc: homebloc,
                                          issearch: true,
                                          size: size,
                                          data: data,
                                          context: context);
                                    }),
                              ),
                              GestureDetector(
                                onTap: () {
                                  bloc.add(ClearDetails());
                                },
                                child: Container(
                                  height: size.height / 19,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Text(
                                      'Clear filter',
                                      style: TextStyle(
                                        fontFamily: 'dexb',
                                        color: Colors.black,
                                        fontSize: size.width / 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
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
                      },
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
