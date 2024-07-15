import 'package:detail_dex/screens/user/view_details/view_tile.dart';
import 'package:flutter/material.dart';

class ViewDetails extends StatefulWidget {
  const ViewDetails({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  late TextEditingController namecontroller;
  late TextEditingController notecontroller;
  late TextEditingController phonecontroller;

  @override
  void initState() {
    super.initState();
    namecontroller = TextEditingController(text: widget.data['name']);
    phonecontroller =
        TextEditingController(text: '+91 ${widget.data['number']}');
    notecontroller = TextEditingController(text: widget.data['note']);
  }

  @override
  void dispose() {
    namecontroller.dispose();
    phonecontroller.dispose();
    notecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            'Personal Details',
            style: TextStyle(
              fontFamily: 'dex2',
              color: Colors.white,
              fontSize: size.width / 20,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: viewTileWidget(
            size: size,
            namecontroller: namecontroller,
            phonecontroller: phonecontroller,
            notecontroller: notecontroller,
            data: widget.data,
            context: context));
  }
}
