import 'package:http/http.dart' as http;
import 'dart:convert';

import 'WeatherModel.dart';



class Network{
  Future<WeatherModel> getWeather(String city) async{
    final result = await http.Client().get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=e0c1c5616ee606f33826dba507277d6c"));

    if(result.statusCode != 200)
      throw Exception();

    return parsedJson(result.body);
  }

  WeatherModel parsedJson(final response){
    final jsonDecoded = json.decode(response);

    final jsonWeather = jsonDecoded["main"];
    final jsonWeather2 = jsonDecoded["weather"];
    final jsonWeather3 = jsonDecoded["wind"];
    print(jsonWeather);
    print(jsonWeather2[0]);

    return WeatherModel.fromJson(jsonWeather,jsonWeather2[0],jsonWeather3);
  }
}