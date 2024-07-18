import 'package:detail_dex/screens/admin/add_exicutives/functions.dart';
import 'package:detail_dex/screens/admin/bloc/admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExicutivesPage extends StatefulWidget {
  AddExicutivesPage({super.key, required this.isedit, required this.data});
  final bool isedit;
  final Map<String, dynamic> data;

  @override
  State<AddExicutivesPage> createState() => _AddExicutivesPageState();
}

class _AddExicutivesPageState extends State<AddExicutivesPage> {
  bool loading = false;

  FocusNode focusNodeaddex1 = FocusNode();

  FocusNode focusNodeaddex2 = FocusNode();

  FocusNode focusNodeaddex3 = FocusNode();

  GlobalKey<FormState> addexkey = GlobalKey<FormState>();

  TextEditingController addexusernamecontroller = TextEditingController();

  TextEditingController addexphonenumbercontroller = TextEditingController();

  TextEditingController addexpasswordcontroller = TextEditingController();

  final AdminBloc bloc = AdminBloc();
  @override
  void initState() {
    if (widget.isedit) {
      addexusernamecontroller.text = widget.data['name'];
      addexphonenumbercontroller.text = widget.data['number'];
      addexpasswordcontroller.text = widget.data['password'];
    }
    super.initState();
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
          widget.isedit ? 'Edit Executive' : 'Add Executive',
          style: TextStyle(
            fontFamily: 'dex2',
            color: Colors.white,
            fontSize: size.width / 20,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width / 30),
          child: Form(
            key: addexkey,
            child: Column(
              children: [
                SizedBox(
                  height: size.width / 10,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  focusNode: focusNodeaddex1,
                  style: TextStyle(
                    fontFamily: 'dex1',
                    color: Colors.white,
                    fontSize: size.width / 24,
                  ),
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Add Exicutive Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Executive Name',
                      labelStyle: TextStyle(
                        fontFamily: 'dex1',
                        color: Colors.white,
                        fontSize: size.width / 35,
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.white))),
                  controller: addexusernamecontroller,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  focusNode: focusNodeaddex2,
                  style: TextStyle(
                    fontFamily: 'dex1',
                    color: Colors.white,
                    fontSize: size.width / 24,
                  ),
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add phone number';
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
                      labelText: 'Executive Mobile Number',
                      labelStyle: TextStyle(
                        fontFamily: 'dex1',
                        color: Colors.white,
                        fontSize: size.width / 35,
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.white))),
                  controller: addexphonenumbercontroller,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  focusNode: focusNodeaddex3,
                  style: TextStyle(
                    fontFamily: 'dex1',
                    color: Colors.white,
                    fontSize: size.width / 24,
                  ),
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add Password';
                    }
                    if (value.length <= 3) {
                      return 'Password contains atleast 4 digits';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontFamily: 'dex1',
                        color: Colors.white,
                        fontSize: size.width / 35,
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.white))),
                  controller: addexpasswordcontroller,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                BlocBuilder<AdminBloc, AdminState>(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is AddExicutiveLoadingState) {
                      loading = state.istrue;
                    }
                    return Material(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: const Color.fromARGB(121, 129, 128, 128),
                        onTap: () {
                          if (!loading) {
                            addexicutives(
                                isedit: widget.isedit,
                                id: widget.data['id'] ?? '',
                                bloc: bloc,
                                focusNodeaddex1: focusNodeaddex1,
                                focusNodeaddex2: focusNodeaddex2,
                                focusNodeaddex3: focusNodeaddex3,
                                context: context,
                                aadexnamecontroller: addexusernamecontroller,
                                addexmobilercontroller:
                                    addexphonenumbercontroller,
                                addexpasswordcontroller:
                                    addexpasswordcontroller,
                                addexkey: addexkey);
                          }
                        },
                        child: Container(
                          height: size.height / 18,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: loading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.black,
                                ))
                              : Center(
                                  child: Text(widget.isedit ? 'Edit' : 'Add',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width / 25,
                                          fontFamily: 'dexb')),
                                ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
