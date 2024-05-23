import 'package:flutter/foundation.dart';
import 'package:weather_app2/data/models/settings_model.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import 'package:weather_app2/data/sharedPreferences/user_preferences.dart';

class UserData extends ChangeNotifier {
  final userPrefs = UserPreferences();
  List<WeatherModel> _searchHistory = [];
  List<WeatherModel> _favoriteCitys = [];
  String _selectedTemperature = "Celsius";

  get selectedTemperature => _selectedTemperature;

  //TEMPERATURA
  //Retorna a temperatura ja convertida com base na seleção do usuário
  //A API fornece a temperatura em celsius já
  String getConvertedTemperature(String userWeatherTemp) {
    switch (_selectedTemperature) {
      case "Fahrenheit":
        return "${((int.parse(userWeatherTemp) * 9 / 5) + 32).toString()}°F";
      case "Celsius":
        return "$userWeatherTemp°C";
      default:
        return "$userWeatherTemp°C";
    }
  }

  loadUserTemperature() async {
    _selectedTemperature = await userPrefs.loadTemperature() ?? "Celsius";
    notifyListeners();
  }

  updateUserTemperature(String newTemperature) {
    userPrefs.saveTemperature(newTemperature);
    loadUserTemperature();
    notifyListeners();
  }

  searchHistoryAdd(WeatherModel weather) {
    _searchHistory.add(weather);
  }

  favoriteCitysAdd(WeatherModel weather) {
    _favoriteCitys.add(weather);
  }

  get searchHistory => _searchHistory.reversed.toList();
  get favoriteCitys => _favoriteCitys;

  loadUserData() async {
    _searchHistory = await userPrefs.loadHistory();
    _favoriteCitys = await userPrefs.loadFavorites();
    loadUserTemperature();
  }

  saveUserHistory() {
    userPrefs.saveUserHistory(_searchHistory);
  }

  saveUserFavorite(WeatherModel result) {
    bool isFavorite = false;

    for (WeatherModel weather in _favoriteCitys) {
      if (weather.city == result.city) {
        isFavorite = true;
      }
    }
    if (isFavorite == false) {
      _favoriteCitys.add(result);
    }
  }

  clearFavorites() {
    _favoriteCitys.clear();
  }

  clearHistory() {
    _searchHistory.clear();
    saveUserHistory();
  }
}
