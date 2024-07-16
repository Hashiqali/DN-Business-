import 'package:detail_dex/screens/admin/add_exicutives/add_exicutives.dart';
import 'package:detail_dex/screens/admin/list_exicutives/list_exicutives.dart';
import 'package:flutter/material.dart';

class HomeScreenAdmin extends StatelessWidget {
  const HomeScreenAdmin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Text(
          'Admin',
          style: TextStyle(
            fontFamily: 'dex2',
            color: Colors.white,
            fontSize: size.width / 20,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width / 35),
        child: Column(
          children: [
            SizedBox(
              height: size.height / 5,
              width: size.width,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(size.width / 30),
                          child: Text(
                            'Today Clients',
                            style: TextStyle(
                              fontFamily: 'dex2',
                              color: Colors.white,
                              fontSize: size.width / 25,
                            ),
                          ),
                        ),
                        Text(
                          '10',
                          style: TextStyle(
                            fontFamily: 'dex2',
                            color: Colors.white,
                            fontSize: size.width / 10,
                          ),
                        ),
                        SizedBox(
                          height: size.width / 30,
                        )
                      ],
                    ),
                  )),
                  SizedBox(
                    width: size.width / 50,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(size.width / 30),
                          child: Text(
                            'Total Clients',
                            style: TextStyle(
                              fontFamily: 'dex2',
                              color: Colors.white,
                              fontSize: size.width / 25,
                            ),
                          ),
                        ),
                        Text(
                          '10',
                          style: TextStyle(
                            fontFamily: 'dex2',
                            color: Colors.white,
                            fontSize: size.width / 10,
                          ),
                        ),
                        SizedBox(
                          height: size.width / 30,
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: size.width / 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => ListExicutives()));
              },
              child: Container(
                height: size.height / 10,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: size.width / 20),
                      child: Text(
                        'Executives',
                        style: TextStyle(
                          fontFamily: 'dexb',
                          color: Colors.black,
                          fontSize: size.width / 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.width / 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => AddExicutivesPage(
                          isedit: false,
                          data: {},
                        )));
              },
              child: Container(
                height: size.height / 15,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    'Add Executive',
                    style: TextStyle(
                      fontFamily: 'dexb',
                      color: Colors.black,
                      fontSize: size.width / 30,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
