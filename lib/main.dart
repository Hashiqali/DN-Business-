import 'package:detail_dex/screens/user/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCggqLlO6UsaafQXUpioG2NTLEA-iPFbgk",
          appId: "1:203244352939:android:4c3a49f017dbb3b3e70eee",
          messagingSenderId: "203244352939",
          projectId: "detaildex-cf7a6",
          storageBucket: "detaildex-cf7a6.appspot.com",
          androidClientId: "com.slashi.detail_dex"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
