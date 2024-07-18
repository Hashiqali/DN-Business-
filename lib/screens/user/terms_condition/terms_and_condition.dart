import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

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
          'Terms and Conditions',
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

1. Introduction

Welcome to DN Business. These Terms and Conditions govern your use of our mobile application. By using our App, you agree to comply with and be bound by these Terms. If you do not agree to these Terms, please do not use our App.

2. Use of the App

You agree to use the App only for lawful purposes and in a way that does not infringe the rights of, restrict, or inhibit anyone else's use and enjoyment of the App. You must not use the App for any illegal or unauthorized purpose.

3. Data Collection

We collect and process client details such as name, location, and phone number for future reference and client management purposes. We do not share this data with third parties. By using the App, you consent to the collection and use of your information as described in our Privacy Policy.

4. Intellectual Property

All content, features, and functionality on the App, including but not limited to text, graphics, logos, icons, and images, are the exclusive property of DN Business and are protected by copyright, trademark, and other intellectual property laws. You may not reproduce, distribute, modify, or create derivative works of any part of the App without our prior written consent.

5. Termination

We reserve the right to terminate or suspend your access to the App at our sole discretion, without notice or liability, for any reason, including if we believe you have violated these Terms.

6. Limitation of Liability

To the maximum extent permitted by law, DN Business shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses, resulting from your use of the App.

7. Changes to Terms

We may update these Terms from time to time. When we do, we will revise the "Effective Date" at the top of these Terms. We encourage you to review these Terms periodically to stay informed about our terms and conditions.

8. Contact Us

If you have any questions or concerns about these Terms, please contact us at hashiqali3080-@gmail.com.''',
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
