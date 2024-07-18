import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

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
          'Privacy and Policy',
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
            '''DN Business

Effective Date: 18-07-2024

Welcome to DN Business. We are committed to protecting your privacy. This Privacy Policy explains how we collect, use, and safeguard your information when you use our mobile application.

We may collect and process the following information: personal data such as your name, location, and phone number. This information is collected for future reference and client management purposes. Please note that we do not share this data with third parties.

We use the information we collect to improve, personalize, and expand our services. By understanding and analyzing how you use our App, we can develop new features and services that better meet your needs.

We are committed to protecting the security of your information. We use a variety of security technologies and procedures to help protect your personal data from unauthorized access, use, or disclosure.

By using our App, you consent to the collection and use of your information as described in this Privacy Policy. If you have any questions about this Privacy Policy, please contact us at hashiqali3080-@gmail.com.''',
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
