import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiRepository extends GetxController {
  List<dynamic> listData = [];

  Future<List<dynamic>> fetchApiData() async {
    final baseUrl = Uri.parse('https://api.carro.cash/user/app/historic');

    const token = 'b1933a3d-7d24-4c0c-baf1-663db105cce9';
    final headers = {'security-token': token};

    final response = await http.get(baseUrl, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var result = <Map<String, dynamic>>[];
      print(jsonData);
      for (var item in jsonData['data']) {
        result.add({
          'name': item['name'],
          'plate': item['plate'],
        });
      }

      return result;
    } else {
      print('Falha na solicitação: ${response.statusCode}');
      throw Exception('Falha na solicitação: ${response.statusCode}');
    }
  }

  Future fetchDataFromAPI() async {
    try {
      await fetchApiData().then((value) => listData = value);
    } catch (e) {
      print('Algo deu errado! $e');
    }
  }
}
