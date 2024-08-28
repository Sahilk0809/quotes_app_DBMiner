import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quotes_app_databse/helper/api_helper.dart';
import 'dart:convert';

import '../modal/quote_modal.dart';

class QuoteController extends GetxController {
  var apiHelper = ApiHelper();
  Rxn<QuoteModal> quoteModal = Rxn<QuoteModal>();

  Future<void> fetchApiData(String filter) async {
    final data = await apiHelper.fetchApi(filter);
    quoteModal.value = QuoteModal.fromMap(data);
  }

  @override
  void onInit() {
    super.onInit();
    fetchApiData('happiness');
  }
}



// inspiration
// life
// love
// wisdom
// motivational
// friendship
// happiness
