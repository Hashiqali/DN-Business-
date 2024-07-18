import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'About',
          style: TextStyle(
            fontFamily: 'dex2',
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: size.width * 0.05,
            top: size.width * 0.05,
            left: size.width * 0.025,
            right: size.width * 0.025,
          ),
          child: const Text(
            '''About DN Business

Welcome to DN Business, a powerful and intuitive app designed to help you manage and organize your client information efficiently. Our goal is to provide a seamless experience for business professionals looking to keep track of their client details for future purposes.

Key Features:

Client Information Management: Easily collect and store client details such as name, location, and phone number.
Future Reference: Keep your client information organized and accessible for future use.
Data Privacy: We are committed to protecting your data. Your client information is stored securely and is not shared with any third parties.
At DN Business, we understand the importance of maintaining accurate and up-to-date client information. Our app is designed to streamline this process, making it easier for you to focus on growing your business. We are dedicated to continuously improving our app to meet your needs and exceed your expectations.

Thank you for choosing DN Business. If you have any questions, feedback, or need assistance, please feel free to contact us at hashiqali3080-@gmail.com. We are here to help!''',
            style: TextStyle(
              fontFamily: 'dex2',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
