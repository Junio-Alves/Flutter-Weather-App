import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app2/data/models/weather_model.dart';

class UserPreferences {
  //salvar o local do usuário
  void saveUserLocal(WeatherModel userWeather) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //converte o objeto WeatherModel em Map, logo após em json.
    final userWeatherJson = jsonEncode(userWeather.toMap());
    await prefs.setString("userPreferences", userWeatherJson);
  }

  Future<Map<String, dynamic>> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> userWeatherJson;
    //verifica se "userPreferences" está vazia
    if (prefs.getString("userPreferences") != null) {
      userWeatherJson = jsonDecode(prefs.getString("userPreferences")!);
      return userWeatherJson;
    } else {
      return userWeatherJson = {"null": "null"};
    }
  }
}
