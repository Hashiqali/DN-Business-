import 'package:flutter/material.dart';

class ExicutivesPage extends StatelessWidget {
  const ExicutivesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '',
          style: TextStyle(
            fontFamily: 'dex2',
            color: Colors.white,
            fontSize: size.width / 20,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(139, 158, 158, 158),
        onPressed: () async {},
        child: Icon(
          color: Colors.white,
          Icons.add_box,
          size: size.width / 11,
        ),
      ),
    );
  }
}
