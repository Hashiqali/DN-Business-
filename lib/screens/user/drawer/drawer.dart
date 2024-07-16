import 'package:detail_dex/screens/user/drawer/functions.dart';
import 'package:detail_dex/screens/user/splash/splash.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      child: Drawer(
        backgroundColor: const Color.fromARGB(255, 15, 14, 14),
        surfaceTintColor: const Color.fromARGB(255, 82, 82, 82),
        elevation: 10,
        width: size.width / 1.5,
        child: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 9,
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.width / 15,
                          ),
                          CircleAvatar(
                            backgroundImage:
                                const AssetImage('assets/images/user.png'),
                            radius: size.width / 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: size.width / 40),
                                child: SizedBox(
                                  width: size.width / 1.7,
                                  child: Center(
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      exicutivename,
                                      style: TextStyle(
                                        fontFamily: 'dexb',
                                        color: Colors.white,
                                        fontSize: size.width / 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '+91 $exicutiveNumber',
                            style: TextStyle(
                              fontFamily: 'dexb',
                              color: Colors.white,
                              fontSize: size.width / 30,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width / 25),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: size.width / 25),
                                  child: const Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Ink(
                            height: size.height / 15,
                            width: size.width / 1.5,
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width / 25),
                                    child: Text(
                                      'Terms and Conditions',
                                      style: TextStyle(
                                        fontFamily: 'dex2',
                                        color: Colors.white,
                                        fontSize: size.width / 28,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Ink(
                            height: size.height / 15,
                            width: size.width / 1.5,
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width / 25),
                                    child: Text(
                                      'Privacy and Policy',
                                      style: TextStyle(
                                        fontFamily: 'dex2',
                                        color: Colors.white,
                                        fontSize: size.width / 28,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Ink(
                            height: size.height / 15,
                            width: size.width / 1.5,
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width / 25),
                                    child: Text(
                                      'About',
                                      style: TextStyle(
                                        fontFamily: 'dex2',
                                        color: Colors.white,
                                        fontSize: size.width / 28,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Ink(
                            height: size.height / 15,
                            width: size.width / 1.5,
                            child: InkWell(
                              onTap: () {
                                alertLogout(context: context, size: size);
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width / 25),
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(
                                        fontFamily: 'dexb',
                                        color: Colors.red,
                                        fontSize: size.width / 28,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
