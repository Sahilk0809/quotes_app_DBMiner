import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_databse/view/screens/home_screen.dart';
import 'controller/api_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quote App',
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomeScreen(),
        ),
      ],
    );
  }
}
