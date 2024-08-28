import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screens/home_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        currentIndex = index;
        if (index == 0) {
          Get.to(() => const HomeScreen());
        } else if (index == 1) {
          // Get.to(BackgroundImageChangeScreen());
        } else if (index == 2) {
          Get.to(() => const LikedScreen());
        }
      },
      selectedItemColor: Colors.blue,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Background'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
      ],
    );
  }
}

int currentIndex = 0;
