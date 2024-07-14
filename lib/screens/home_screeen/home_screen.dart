import 'package:detail_dex/screens/add_details/add_edit_details.dart';
import 'package:detail_dex/screens/list_details/list_details.dart';
import 'package:detail_dex/screens/search/search.dart';
import 'package:flutter/material.dart';

List alldetails = [];

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
                size: size, controller: searchcontroller, details: alldetails),
            Expanded(child: ListDetails(size: size)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(139, 158, 158, 158),
        onPressed: () {
          if (focusNodeSearch.hasFocus) {
            focusNodeSearch.unfocus();
          }
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => const AddDetails(
                    isedit: false,
                    editdata: {},
                  )));
        },
        child: Icon(
          color: Colors.white,
          Icons.add_box,
          size: size.width / 11,
        ),
      ),
    );
  }
}
