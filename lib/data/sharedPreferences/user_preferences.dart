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

  void saveUserHistory(List<WeatherModel> searchHistory) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userWeatherJson = [];
    for (WeatherModel weatherModel in searchHistory) {
      userWeatherJson.add(jsonEncode(weatherModel.toMap()));
    }
    await prefs.setStringList("userHistory", userWeatherJson);
  }

  Future<List<WeatherModel>> loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userHistoryJson = prefs.getStringList("userHistory");
    if (userHistoryJson == null) {
      return [];
    } else {
      List<WeatherModel> userHistory = [];
      for (String weatherJson in userHistoryJson) {
        userHistory.add(WeatherModel.fromMap(jsonDecode(weatherJson)));
      }
      return userHistory;
    }
  }

  void saveUserFavorites(List<WeatherModel> searchHistory) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userWeatherJson = [];
    for (WeatherModel weatherModel in searchHistory) {
      userWeatherJson.add(jsonEncode(weatherModel.toMap()));
    }
    await prefs.setStringList("userFavorites", userWeatherJson);
  }

  Future<List<WeatherModel>> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userHistoryJson = prefs.getStringList("userFavorites");
    if (userHistoryJson == null) {
      return [];
    } else {
      List<WeatherModel> userHistory = [];
      for (String weatherJson in userHistoryJson) {
        userHistory.add(WeatherModel.fromMap(jsonDecode(weatherJson)));
      }
      return userHistory;
    }
  }

  saveTemperature(String userTemperature) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userTemperature", userTemperature);
  }

  loadTemperature() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userTemperature = await prefs.getString("userTemperature");
    return userTemperature;
  }
}
