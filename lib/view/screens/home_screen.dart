import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:quotes_app_databse/controller/api_controller.dart';
import '../../components/bottom_navigation_bar.dart';
import '../../components/category_selector.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text('Quotes App'),
        centerTitle: true,
        scrolledUnderElevation: 0.1,
        elevation: 0,
      ),
      body: Expanded(
        child: Obx(
          () {
            if (controller.quoteModal.value == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return LiquidSwipe.builder(
              slideIconWidget: const Icon(Icons.arrow_back),
              itemCount: controller.quoteModal.value!.results.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.quoteModal.value!.results[index].content,
                        style: const TextStyle(
                          fontSize: 24,
                          fontFamily: 'Playfair Display',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '- ${controller.quoteModal.value!.results[index].author}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class LikedScreen extends StatelessWidget {
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Quotes'),
      ),
      // body: ListView.builder(
      //   itemCount: likedQuotes!.length ?? 1,
      //   itemBuilder: (context, index) {
      //     return Card(
      //       margin: const EdgeInsets.all(8.0),
      //       elevation: 4.0,
      //       child: ListTile(
      //         title: Text(
      //           likedQuotes[index]['quote']! ?? '',
      //           style: const TextStyle(fontSize: 18),
      //         ),
      //         subtitle: Text('- ${likedQuotes[index]['author']}'),
      //         trailing: const Icon(Icons.favorite, color: Colors.red),
      //       ),
      //     );
      //   },
      // ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

List? likedQuotes;
var controller = Get.put(QuoteController());
