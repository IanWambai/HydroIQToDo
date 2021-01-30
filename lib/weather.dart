import 'package:http/http.dart' as http;

Future<String> getWeatherData() async {
  final response = await http.get(
      'http://data.fixer.io/api/convert?access_key=a07f5a495053fbad8ce5a3149e77b1f8&from=USD&to=KES&amount=1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load weather data');
  }
}
