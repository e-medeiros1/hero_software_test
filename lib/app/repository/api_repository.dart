import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiRepository extends GetxController {
  var listData = [].obs;
  var result = [].obs;
  Future<List<dynamic>> fetchApiData() async {
    final baseUrl = Uri.parse('https://api.carro.cash/user/app/historic');

    const token = 'b1933a3d-7d24-4c0c-baf1-663db105cce9';
    final headers = {'security-token': token};

    final response = await http.get(baseUrl, headers: headers);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      log(jsonData);
      for (var item in jsonData['data']) {
        result.add({
          'name': item['name'],
        });
      }

      return result;
    } else {
      log('Falha na solicitação: ${response.statusCode}');
      throw Exception('Falha na solicitação: ${response.statusCode}');
    }
  }

  Future fetchDataFromAPI() async {
    try {
      fetchApiData().then((value) => listData.value = value).toString();
    } catch (e) {
      throw Exception('Algo deu errado! $e');
    }
  }
}
