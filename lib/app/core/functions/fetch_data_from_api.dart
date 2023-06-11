import 'package:http/http.dart' as http;

Future<void> fetchApiData() async {
  //URL da API deve ser referente a requisição que tu precisa.
  //Passa ela como parâmetro e chama a função no passando a url do que tu precisa!
  final url = Uri.parse('https://api.carro.cash/user/app/historic');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonData = response.body;
    print(jsonData);
  } else {
    print('Falha na solicitação: ${response.statusCode}');
  }
}
