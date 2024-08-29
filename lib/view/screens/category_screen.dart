import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:quotes_app_databse/controller/quotes_controller.dart';

Future categoryModalBottomSheet(
    BuildContext context, QuotesController controller) {
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return showModalBottomSheet(
    showDragHandle: true,
    isScrollControlled: true,
    context: context,
    builder: (context) => Container(
      height: height * 0.6,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Text(
              'Choose according to you',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: controller.category.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    if (controller.category[index]['category'] == 'General') {
                      controller.quotes.value = controller.quoteList;
                      controller.quotes.refresh();
                      controller.initialImagesDeclare();
                      controller.liquidController = LiquidController();
                      Get.back();
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Get.snackbar(
                          'Quotes Category',
                          'Showing general quotes',
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 3),
                        );
                      });
                    } else {
                      controller.quotes.value = controller.quoteList
                          .where(
                            (quote) => quote.category == controller.category[index]['category']).toList();
                      controller.quotes.refresh();
                      controller.liquidController = LiquidController();
                      controller.initialImagesDeclare();
                      Get.back();
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Get.snackbar(
                          'Quotes Category Changed',
                          snackPosition: SnackPosition.BOTTOM,
                          'Showing ${controller.category[index]['category']} quotes',
                          duration: const Duration(seconds: 3),
                        );
                      });
                    }
                  },
                  child: Container(
                    height: height * 0.1,
                    width: width * 0.4,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(controller.category[index]['img']!),
                      ),
                    ),
                    child: Text(
                      controller.category[index]['category']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
