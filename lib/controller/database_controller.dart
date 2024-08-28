import 'package:get/get.dart';
import 'package:quotes_app_databse/helper/database_helper.dart';

class DatabaseController extends GetxController {
  RxList data = [].obs;

  @override
  void onInit() {
    super.onInit();
    initDb();
  }

  Future initDb() async {
    await DatabaseHelper.databaseHelper.database;
  }

  Future<void> insertData(String quote, String author) async {
    await DatabaseHelper.databaseHelper.insertData(quote, author);
    await getData();
  }

  Future getData() async {
    data.value = await DatabaseHelper.databaseHelper.readAllData();
    return data;
  }

  Future<void> deleteData(int id) async {
    await DatabaseHelper.databaseHelper.deleteData(id);
  }
}
