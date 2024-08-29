import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quotes_app_databse/view/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
        const Duration(
          seconds: 4,
        ), (timer) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueAccent.withOpacity(0.7),
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          height: double.infinity,
          color: Colors.black.withOpacity(0.3),
          child: SizedBox(
            height: 300,
            width: 300,
            child: LottieBuilder.asset(
              'assets/lottie/Animation - 1724956914782.json',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
