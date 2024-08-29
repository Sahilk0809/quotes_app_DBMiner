import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:quotes_app_databse/view/screens/category_screen.dart';
import 'package:quotes_app_databse/view/screens/like_screen.dart';
import '../../controller/quotes_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () {
              if (controller.quoteList.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return LiquidSwipe.builder(
                liquidController: controller.liquidController,
                slideIconWidget: const Icon(Icons.arrow_back_outlined),
                fullTransitionValue: 300,
                enableSideReveal: false,
                preferDragFromRevealedArea: false,
                enableLoop: false,
                ignoreUserGestureWhileAnimating: true,
                itemCount: controller.quotes.length,
                itemBuilder: (context, index) {
                  // if index goes out of bound assigning index = 0
                  index = index % controller.quotes.length;

                  if (index >= controller.quotes.length) {
                    return Container(); // if index is out of bound
                  }
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(controller.initialImages[index]),
                      ),
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.quotes[index].category,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            controller.quotes[index].quote,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '- ${controller.quotes[index].author}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          IconButton(
                            onPressed: () async {
                              // await controller.addQuoteToFavorites(index);
                            },
                            icon: const Icon(
                              Icons.favorite_outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            top: 40,
            left: 15,
            child: GestureDetector(
              onTap: () => categoryModalBottomSheet(context, controller),
              child: Container(
                height: height * 0.05,
                width: width * 0.32,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.5),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.category),
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 90,
            top: 40,
            child: GestureDetector(
              // onTap: () => favouriteSheet(context, controller),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.5),
                ),
                child: const Icon(Icons.favorite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

var controller = Get.put(QuotesController());
