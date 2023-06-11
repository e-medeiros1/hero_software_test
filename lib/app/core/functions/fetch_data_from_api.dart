import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchApiData() async {
  //URL da API deve ser referente a requisição que tu precisa.
  //Passa ela como parâmetro e chama a função no passando a url do que tu precisa!
  final url = Uri.parse('https://api.carro.cash/user/app/historic');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    var result = <Map<String, dynamic>>[];
    print(jsonData);
    for (var item in jsonData['valorDaChaveQueTuPrecisa']) {
      result.add({
        'nomeDoValorNoJson': item['nomeDoValorNaNovaLista'],
        //Exemplo se o json retornasse os dados de um site:
        //'link': item['link'],
        //'title': item['title'],
        //'description': item['description'],
        //'favicon': item['favicon'],
      });
    }

    return result;
  } else {
    throw Exception('Falha na solicitação: ${response.statusCode}');
  }
}

//Para pegar os valores da lista gerada em outra tela, basta chamar a função:
//****Crie a lista para receber os dados:****
//List<dynamic> ListData = [];

/*
Future fetchDataFromAPI() async {
  try {
await fetchApiData().then((value) => ListData = value);
  } catch (e) {
     throw Exception('Algo deu errado! $e');
  }
}*/
