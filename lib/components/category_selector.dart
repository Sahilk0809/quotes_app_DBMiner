import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_databse/view/screens/home_screen.dart';
import '../controller/category_controller.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  CategorySelectorState createState() => CategorySelectorState();
}

class CategorySelectorState extends State<CategorySelector> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Obx(
              () => ChoiceChip(
                label: Text(categories[index]),
                selected: categoryController.selectedCategory.value == categories[index],
                selectedColor: Colors.blue[200],
                onSelected: (selected) {
                    categoryController.selectedCategory.value = (selected ? categories[index] : null)!;
                    controller.fetchApiData(selected ? categories[index] : 'Happiness');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

List<String> categories = [
  'Happiness',
  'Love',
  'Success',
  'Motivational',
  'Friendship',
  'Wisdom',
  'Life'
];

var categoryController = Get.put(CategoryController());