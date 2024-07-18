import 'package:connectivity/connectivity.dart';
import 'package:detail_dex/screens/user/add_details/add_edit_details.dart';
import 'package:detail_dex/screens/user/drawer/drawer.dart';
import 'package:detail_dex/screens/user/list_details/list_details.dart';
import 'package:detail_dex/screens/user/search/search.dart';
import 'package:detail_dex/widgets/no_network_widget/no_network_widget.dart';
import 'package:detail_dex/widgets/sort_widget/sort_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

List alldetails = [];

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (focusNodeSearch.hasFocus) {
          focusNodeSearch.unfocus();
        }
      },
      child: Scaffold(
        drawer: const DrawerWidget(),
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  sortdetails(context, size);
                },
                icon: const Icon(EvaIcons.options2))
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            'Details',
            style: TextStyle(
              fontFamily: 'dex2',
              color: Colors.white,
              fontSize: size.width / 20,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: GestureDetector(
          onTap: () {
            if (focusNodeSearch.hasFocus) {
              focusNodeSearch.unfocus();
            }
          },
          child: Column(
            children: [
              searchTile(
                  size: size,
                  controller: searchcontroller,
                  details: alldetails),
              Expanded(child: ListDetails(size: size)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(139, 158, 158, 158),
          onPressed: () async {
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const AddDetails(
                        isedit: false,
                        editdata: {},
                      )));
            }
          },
          child: Icon(
            color: Colors.white,
            Icons.add_box,
            size: size.width / 11,
          ),
        ),
      ),
    );
  }
}
