import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:quotes_app_databse/helper/database_helper.dart';

import '../helper/api_helper.dart';
import '../modal/quote_modal.dart';

class QuotesController extends GetxController {
  RxList data = [].obs;
  var apiHelper = ApiHelper();
  RxList<QuotesModel> quoteList = <QuotesModel>[].obs;
  RxList<QuotesModel> quotes = <QuotesModel>[].obs;
  RxList<String> initialImages = <String>[].obs;
  LiquidController liquidController = LiquidController();
  RxList<QuotesModel> favouriteQuotes = <QuotesModel>[].obs;
  RxList<String> favouriteCategories = <String>[].obs;
  RxInt indexForGlobalUse = 0.obs;
  int check = 0;
  RxString expandedCategory = ''.obs;


  // Method to set the expanded category
  void setExpandedCategory(String category) {
    expandedCategory.value = category;
  }

  List<Map<String, String>> category = [
    {
      'category': 'General',
      'img': 'assets/img/love2.jpg',
    },
    {
      'category': 'Life',
      'img': 'assets/img/nature1.jpg',
    },
    {
      'category': 'Love',
      'img': 'assets/img/love1.jpg',
    },
    {
      'category': 'Success',
      'img': 'assets/img/success2.jpg',
    },
    {
      'category': 'Motivation',
      'img': 'assets/img/motivational1.jpg',
    },
    {
      'category': 'Happiness',
      'img': 'assets/img/happiness2.jpg',
    },
    {
      'category': 'Powerful',
      'img': 'assets/img/powerful2.jpeg',
    },
    {
      'category': 'Friendship',
      'img': 'assets/img/friendship1.jpg',
    },
    {
      'category': 'Humor',
      'img': 'assets/img/humor2.jpeg',
    },
  ];

  Map<String, List<String>> imageList = {
    'Life': [
      'assets/img/nature1.jpg',
      'assets/img/nature2.jpeg',
      'assets/img/nature3.jpeg',
      'assets/img/nature4.jpg',
      'assets/img/nature5.jpg',
    ],
    'Love': [
      'assets/img/love1.jpg',
      'assets/img/love2.jpg',
      'assets/img/love3.jpg',
      'assets/img/love4.webp',
    ],
    'Success': [
      'assets/img/success1.webp',
      'assets/img/success2.jpg',
      'assets/img/success3.jpg',
      'assets/img/success4.jpeg',
    ],
    'Motivation': [
      'assets/img/motivational1.jpg',
      'assets/img/motivational2.jpg',
      'assets/img/motivational3.webp',
    ],
    'Happiness': [
      'assets/img/happiness1.webp',
      'assets/img/happiness2.jpg',
    ],
    'Powerful': [
      'assets/img/powerful1.jpeg',
      'assets/img/powerful2.jpeg',
      'assets/img/powerful3.jpeg',
      'assets/img/powerful4.jpg',
    ],
    'Friendship': [
      'assets/img/friendship1.jpg',
      'assets/img/friendship3.jpg',
    ],
    'Humor': [
      'assets/img/humor.jpg',
      'assets/img/humor2.jpeg',
      'assets/img/humor3.jpg',
      'assets/img/humor4.jpg',
    ],
  };

  @override
  void onInit() {
    super.onInit();
    initDb();
    fetchApiData();
    readFavouriteQuote();
  }

  Future<RxList<QuotesModel>> fetchApiData() async {
    List? data = await apiHelper.fetchApi();
    if (data.isNotEmpty) {
      print('--------------------Fetch Api Data------------------');
      quoteList.value = data.map((e) => QuotesModel.fromJson(e)).toList();
      quoteList.shuffle();
      quotes.value = quoteList;
    }

    // image at initial
    initialImagesDeclare();
    return quoteList;
  }

  void initialImagesDeclare() {
    Random random = Random();
    initialImages.value = List.generate(
      quoteList.length,
      (index) {
        final category = quoteList[index].category;
        final image = imageList[category];
        if (image == null || image.isEmpty) '';
        return image![random.nextInt(image.length)];
      },
    );
    print(initialImages.length);
  }

  Future initDb() async {
    await DatabaseHelper.databaseHelper.database;
  }

  void checkFavouriteExistBefore(QuotesModel quote) {
    check = 0;
    for (int i = 0; i < favouriteQuotes.length; i++) {
      if (quote.quote == favouriteQuotes[i].quote) {
        check = 1;
        Get.snackbar('Already', 'The quote is already added to favourite!',
            snackPosition: SnackPosition.BOTTOM,
            colorText: CupertinoColors.white);
      }
    }
    if (check == 0) {
      insertFavouriteQuote(quote);
      check = 1;
    }
  }

  Future<void> deleteFavouriteQuote(int id) async {
    await DatabaseHelper.databaseHelper.deleteFavouriteQuote(id);
    readFavouriteQuote();
    Get.snackbar(
      'Removed',
      'Quote removed from favourite',
      snackPosition: SnackPosition.BOTTOM,
      colorText: CupertinoColors.white,
    );
  }

  void toggleColorOfFavourite(int index){
    quotes[index].isFavorite = true;
    quotes.refresh();
  }

  Future<void> insertFavouriteQuote(QuotesModel quote) async {
    await DatabaseHelper.databaseHelper.addFavouriteInDatabase(
        quote.quote, quote.author, quote.category, quote.isFavorite ? 0 : 1);
    Get.snackbar('Added!', 'Quote added to favourite',
        snackPosition: SnackPosition.BOTTOM, colorText: CupertinoColors.white);
    readFavouriteQuote();
  }

  Future<void> readFavouriteQuote() async {
    favouriteQuotes.value =
        await DatabaseHelper.databaseHelper.readFavouriteQuotes();
  }
}
