import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/WeatherModel.dart';

class ExtraWeather extends StatelessWidget {
  final WeatherModel temp;
  ExtraWeather(this.temp);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(
              CupertinoIcons.wind,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              temp.wind.toString() + " Km/h",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Wind",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        ),
        Column(
          children: [
            Icon(
              CupertinoIcons.drop,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              temp.humidity.toString() + " %",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Humidity",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        ),
        Column(
          children: [
            Icon(
              CupertinoIcons.thermometer,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              temp.getFeelsLike.toStringAsFixed(2) + " °C",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Feels like",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        )
      ],
    );
  }
}