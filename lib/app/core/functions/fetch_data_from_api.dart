import 'package:http/http.dart' as http;

Future<void> fetchApiData() async {
  //URL da API deve ser referente a requisição que tu precisa.
  //Passa ela como parâmetro e chama a função no passando a url do que tu precisa!
  final url = Uri.parse('https://api.carro.cash/user/app/historic');

  //token fornecido pela documentação da API: b1933a3d-7d24-4c0c-baf1-663db105cce9
  const token = '';

  final headers = {'security-token': token};

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final jsonData = response.body;
    print(jsonData);
  } else {
    print('Falha na solicitação: ${response.statusCode}');
  }
}
