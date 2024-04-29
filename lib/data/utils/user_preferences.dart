import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app2/data/models/weather_model.dart';

class UserPreferences {
  void savePreferences(WeatherModel userWeather) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userWeatherJson = jsonEncode(userWeather.toMap());
    await prefs.setString("userPreferences", userWeatherJson);
  }

  Future<Map<String, dynamic>> getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userWeatherJson;
    if (prefs.getString("userPreferences") != null) {
      userWeatherJson = jsonDecode(prefs.getString("userPreferences") ?? "");
      return userWeatherJson;
    } else {
      return userWeatherJson = {"null": "null"};
    }
  }
}
