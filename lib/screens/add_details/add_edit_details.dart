import 'package:detail_dex/screens/add_details/functions.dart';
import 'package:detail_dex/screens/bloc/details_bloc.dart';
import 'package:detail_dex/widgets/pick_location/location_take.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({super.key, required this.isedit, required this.editdata});
  final bool isedit;
  final Map<String, dynamic> editdata;

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  final TextEditingController namecontroller = TextEditingController();

  final TextEditingController notecontroller = TextEditingController();

  final TextEditingController phonecontroller = TextEditingController();

  FocusNode focusNode1 = FocusNode();

  FocusNode focusNode2 = FocusNode();

  FocusNode focusNode3 = FocusNode();

  final GlobalKey addkey = GlobalKey<FormState>();
  final DetailsBloc bloc = DetailsBloc();
  bool isloading = false;
  @override
  void initState() {
    if (widget.isedit) {
      namecontroller.text = widget.editdata['name'];
      phonecontroller.text = widget.editdata['number'];
      notecontroller.text = widget.editdata['note'];
      location = widget.editdata['location'];
      address = widget.editdata['address'];
    } else {
      namecontroller.clear();
      phonecontroller.clear();
      notecontroller.clear();
      location = {};
      address = {};
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.isedit ? "Edit Details" : 'Add Details',
          style: TextStyle(
            fontFamily: 'dex2',
            color: Colors.white,
            fontSize: size.width / 20,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Form(
        key: addkey,
        child: ListView(padding: const EdgeInsets.all(20), children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: focusNode1,
            style: TextStyle(
              fontFamily: 'dex1',
              color: Colors.white,
              fontSize: size.width / 24,
            ),
            cursorColor: Colors.white,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please add a name';
              }
              return null;
            },
            decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                labelText: 'Name',
                labelStyle: TextStyle(
                  fontFamily: 'dex1',
                  color: Colors.white,
                  fontSize: size.width / 30,
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
            controller: namecontroller,
          ),
          SizedBox(
            height: size.height / 70,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: focusNode2,
            style: TextStyle(
              fontFamily: 'dex1',
              color: Colors.white,
              fontSize: size.width / 24,
            ),
            cursorColor: Colors.white,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please add a phone number';
              }

              final RegExp regex = RegExp(r'^[0-9]+$');
              if (!regex.hasMatch(value)) {
                return 'Please enter valid phone number';
              }
              if (value.length != 10) {
                return 'Phone number must be 10 digits';
              }
              return null;
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                labelText: 'Phone Number',
                labelStyle: TextStyle(
                  fontFamily: 'dex1',
                  color: Colors.white,
                  fontSize: size.width / 30,
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
            controller: phonecontroller,
          ),
          SizedBox(
            height: size.height / 70,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: focusNode3,
            style: TextStyle(
              fontFamily: 'dex1',
              color: Colors.white,
              fontSize: size.width / 24,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please add a note';
              }
              return null;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'Note',
              labelStyle: TextStyle(
                fontFamily: 'dex1',
                color: Colors.white,
                fontSize: size.width / 30,
              ),
            ),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
            controller: notecontroller,
          ),
          SizedBox(
            height: size.height / 70,
          ),
          BlocBuilder<DetailsBloc, DetailsState>(
            bloc: bloc,
            builder: (context, state) {
              return GestureDetector(
                onTap: () async {
                  focusNode1.unfocus();
                  focusNode2.unfocus();
                  focusNode3.unfocus();
                  PermissionStatus locationStatus =
                      await Permission.location.request();
                  if (locationStatus.isGranted) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => Location(
                              bloc: bloc,
                            )));
                  } else if (locationStatus.isDenied) {
                  } else if (locationStatus.isPermanentlyDenied) {
                    openAppSettings();
                  }
                },
                child: Container(
                  height: size.height / 15,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: location.isEmpty
                        ? const Color.fromARGB(255, 221, 170, 16)
                        : Colors.greenAccent,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: size.width / 20,
                        ),
                        Text(
                          location.isEmpty
                              ? 'Add Location'
                              : 'Location Obtained',
                          style: TextStyle(
                            fontFamily: 'dexb',
                            color: Colors.black,
                            fontSize: size.width / 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: size.height / 40,
          ),
          BlocBuilder<DetailsBloc, DetailsState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is LoadingBuilderState) {
                isloading = true;
              }
              return ElevatedButton(
                onPressed: () {
                  if (!isloading) {
                    submit(
                        id: widget.editdata['id'],
                        bloc: bloc,
                        isedit: widget.isedit,
                        context: context,
                        namecontroller: namecontroller,
                        numbercontroller: phonecontroller,
                        notecontroller: notecontroller,
                        key: addkey);
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: isloading
                    ? Center(
                        child: SizedBox(
                          height: size.width / 13,
                          width: size.width / 13,
                          child: const CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      )
                    : Text(
                        'Submit',
                        style: TextStyle(
                          fontFamily: 'dexb',
                          color: Colors.black,
                          fontSize: size.width / 30,
                        ),
                      ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
