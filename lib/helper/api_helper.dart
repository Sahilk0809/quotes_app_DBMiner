import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class ApiHelper{
  Future<List> fetchApi() async {
    String api = 'https://sheetdb.io/api/v1/erjiyupf985k3';
    Uri url = Uri.parse(api);
    Response response = await http.get(url);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return data;
    } else{
      throw 'Error';
    }
  }
}