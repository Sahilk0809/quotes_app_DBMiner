import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_databse/view/screens/home_screen.dart';
import 'package:quotes_app_databse/view/screens/like_screen.dart';
import 'package:quotes_app_databse/view/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quote App',
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
        ),
      ],
    );
  }
}
