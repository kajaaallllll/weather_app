import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_appp/weather_model.dart';
class WeatherApiClient{
  Future<Weather>? getCurrentWeather(String? location) async{
    var endpoint = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location,{country%20code}&appid=99a1cd0a18069967f59a11383329d5d2&units=metric");
  var response =await http.get(endpoint);
  var body = jsonDecode(response.body);
  print(Weather.fromJson(body).cityName);
  return Weather.fromJson(body);

  }
}