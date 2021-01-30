import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'constants.dart';

Future<String> getWeatherData() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  final response = await http.get(
      'https://api.openweathermap.org/data/2.5/onecall?lat=' +
          position.latitude.toString() +
          '&lon=' +
          position.longitude.toString() +
          '&exclude=minutely,hourly,daily&units=metric&appid=' +
          WEATHER_API_KEY);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    log(response.body);
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load weather data');
  }
}
