import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class ApiHelper{
  Future<Map> fetchApi(String filter) async {
    String api = 'https://api.quotable.io/quotes?tags=$filter';
    Uri url = Uri.parse(api);
    Response response = await http.get(url);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return data;
    } else{
      return {};
    }
  }
}