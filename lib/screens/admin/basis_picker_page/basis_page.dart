import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class BasisPage extends StatelessWidget {
  const BasisPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Client Lists',
          style: TextStyle(
            fontFamily: 'dex2',
            color: Colors.white,
            fontSize: size.width / 20,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width / 25),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                datepicker(context: context, size: size);
              },
              child: Container(
                height: size.height / 15,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
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
                child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5),
                    padding: EdgeInsets.only(top: size.width / 50),
                    itemCount: 5,
                    itemBuilder: (ctx, index) {
                      return Container(
                        color: Colors.amber,
                        height: 50,
                        width: size.width,
                      );
                    }))
          ],
        ),
      ),
    );
  }
}

datepicker({context, size}) async {
  return showMonthPicker(
    backgroundColor: Colors.white,
    headerColor: const Color.fromARGB(255, 35, 34, 34),
    context: context,
    unselectedMonthTextColor: Colors.black,
    cancelWidget: Text(
      'Cancel',
      style: TextStyle(
        fontFamily: 'dexb',
        color: Colors.black,
        fontSize: size.width / 28,
      ),
    ),
    confirmWidget: Text(
      'Ok',
      style: TextStyle(
        fontFamily: 'dexb',
        color: Colors.black,
        fontSize: size.width / 28,
      ),
    ),
    initialDate: DateTime.now(),
  ).then((date) {
    if (date != null) {
      print(date);
    }
  });
}
