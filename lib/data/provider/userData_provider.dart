import 'package:flutter/foundation.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import 'package:weather_app2/data/sharedPreferences/user_preferences.dart';

class UserData extends ChangeNotifier {
  final userPrefs = UserPreferences();
  List<WeatherModel> _searchHistory = [];
  List<WeatherModel> _favoriteCitys = [];
  String? _selectedTemperature;
  String? _selectedSpeed;
  //final bool _isFirstLogin = true;

  get selectedTemperature => _selectedTemperature;
  get searchHistory => _searchHistory.reversed.toList();
  get favoriteCitys => _favoriteCitys;
  get selectedSpeed => _selectedSpeed;

  loadUserData() async {
    _searchHistory = await userPrefs.loadHistory();
    _favoriteCitys = await userPrefs.loadFavorites();
    _selectedTemperature = await userPrefs.loadTemperature() ?? "Celsius";
    _selectedSpeed = await userPrefs.loadSpeed() ?? "Km/h";
  }

  //TEMPERATURA
  //Retorna a temperatura ja convertida com base na seleção do usuário
  //A API fornece a temperatura em celsius já
  String getConvertedTemperature(String userWeatherTemp) {
    switch (_selectedTemperature) {
      case "Fahrenheit":
        return "${((double.parse(userWeatherTemp) * 9 / 5) + 32)}°F";
      case "Kelvin":
        return "${(double.parse(userWeatherTemp) + 273.15)} °K";
      default:
        return "$userWeatherTemp°C";
    }
  }

  updateUserTemperature(String newTemperature) {
    userPrefs.saveTemperature(newTemperature);
    loadUserData();
    notifyListeners();
  }

  String getConvertedSpeed(String userSpeed) {
    final userSpeedConverted = double.parse(userSpeed.replaceAll(" km/h", ""));
    switch (_selectedSpeed) {
      case "Mp/H":
        return "${userSpeedConverted / 1.6093446} mp/h";
      case "M/s":
        return "${userSpeedConverted / 3.6} m/s";
      default:
        return userSpeed;
    }
  }

  updateUserSpeed(String newSpeed) {
    userPrefs.saveSpeed(newSpeed);
    loadUserData();
    notifyListeners();
  }

  //Favoritos
  favoriteCitysAdd(WeatherModel weather) {
    _favoriteCitys.add(weather);
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

  //Historico
  searchHistoryAdd(WeatherModel weather) {
    _searchHistory.add(weather);
  }

  saveUserHistory() {
    userPrefs.saveUserHistory(_searchHistory);
  }

  clearHistory() {
    _searchHistory.clear();
    saveUserHistory();
  }
}
