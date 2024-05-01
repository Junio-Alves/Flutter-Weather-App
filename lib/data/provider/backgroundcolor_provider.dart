import 'package:flutter/material.dart';
import 'package:weather_app2/data/models/weather_model.dart';

class BackgrounColorProvider extends ChangeNotifier {
  Color backgroundColor = Colors.white;
  changeBackgroundColor(WeatherModel weather) {
    if (weather.currently == "dia") {
      backgroundColor = Color.fromARGB(255, 78, 190, 255);
    } else if (weather.currently == "noite") {
      backgroundColor = const Color.fromARGB(255, 172, 40, 224);
    } else {
      backgroundColor = Colors.black;
    }
    notifyListeners();
  }

  List<Color> gradientBackgroundColor(WeatherModel weather) {
    if (weather.currently == "dia") {
      return [
        Color.fromARGB(255, 255, 196, 0),
        Color.fromARGB(255, 253, 207, 0),
      ];
    } else if (weather.currently == "noite") {
      return [
        const Color.fromARGB(255, 172, 40, 224),
        const Color.fromARGB(255, 95, 5, 131)
      ];
    } else {
      return [backgroundColor = Colors.black];
    }
  }
}
