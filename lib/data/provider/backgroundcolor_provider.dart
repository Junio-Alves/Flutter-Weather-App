import 'package:flutter/material.dart';
import 'package:weather_app2/data/models/weather_model.dart';

class BackgrounColorProvider extends ChangeNotifier {
  Color backgroundColor = Colors.white;
  changeBackgroundColor(WeatherModel weather) {
    if (weather.currently == "dia") {
      backgroundColor = Colors.blue;
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
        const Color.fromARGB(255, 255, 187, 0),
        const Color.fromARGB(255, 255, 217, 0)
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
