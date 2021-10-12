import 'package:intl/intl.dart';

class WeatherModel {
  final temp;
  final wind;
  final  humidity;
  final temp_max;
  final  temp_min;
  final description;
  final main;
  final feels_like;



  double get getTemp => temp-272.5;
  double get getMaxTemp => temp_max-272.5;
  double get getMinTemp=> temp_min -272.5;
  double get getFeelsLike=> feels_like-272.5;
  String get getDescription=> description;

  String get getMain{

    switch(main){
      case "Clear":
        {
          return 'assets/sunny.png';
          break;
        }
      case "Clouds":
        {
        return 'assets/thunder.png';
        break;
      }
      case "Snow":
        {
          return 'assets/snow.png';
          break;
        }
      case "Rain":
        {
          return 'assets/rainy.png';
        }
    }
    return '';
  }

  WeatherModel(this.temp, this.wind, this.humidity, this.temp_max, this.temp_min, this.description,this.main,this.feels_like);

  factory WeatherModel.fromJson(Map<String, dynamic> json,Map<String, dynamic> json2,Map<String, dynamic> json3){
    return WeatherModel(
        json["temp"],
        json3["speed"],
        json["humidity"],
        json["temp_max"],
        json["temp_min"],
        json2["description"],
        json2["main"],
        json["feels_like"]
    );
  }

}