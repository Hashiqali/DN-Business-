import 'package:detail_dex/screens/user/bloc/details_bloc.dart';
import 'package:detail_dex/screens/login_screen/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  FocusNode focusNodelogin1 = FocusNode();
  FocusNode focusNodelogin2 = FocusNode();
  GlobalKey<FormState> loginkey = GlobalKey<FormState>();

  TextEditingController usernamecontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();
  final DetailsBloc loginbloc = DetailsBloc();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: EdgeInsets.all(size.width / 25),
            child: Form(
              key: loginkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'DN Business',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'dex2',
                      fontSize: size.width / 11,
                    ),
                  ),
                  SizedBox(
                    height: size.width / 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: focusNodelogin1,
                    style: TextStyle(
                      fontFamily: 'dex1',
                      color: Colors.white,
                      fontSize: size.width / 24,
                    ),
                    cursorColor: Colors.white,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          fontFamily: 'dex1',
                          color: Colors.white,
                          fontSize: size.width / 35,
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.white))),
                    controller: usernamecontroller,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: focusNodelogin2,
                    style: TextStyle(
                      fontFamily: 'dex1',
                      color: Colors.white,
                      fontSize: size.width / 24,
                    ),
                    cursorColor: Colors.white,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Password';
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
                    controller: passwordcontroller,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  BlocBuilder<DetailsBloc, DetailsState>(
                    bloc: loginbloc,
                    builder: (context, state) {
                      if (state is LoginLoadingEventState) {
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
                              login(
                                  focusNodelogin1: focusNodelogin1,
                                  focusNodelogin2: focusNodelogin2,
                                  loginkey: loginkey,
                                  loginbloc: loginbloc,
                                  usercontroller: usernamecontroller,
                                  passwordcontroller: passwordcontroller,
                                  context: context);
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
                                    child: Text('Login',
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
      ),
    );
  }
}
