import 'package:flutter/foundation.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import 'package:weather_app2/data/sharedPreferences/user_preferences.dart';

class UserData extends ChangeNotifier {
  final userPrefs = UserPreferences();
  List<WeatherModel> _searchHistory = [];
  List<WeatherModel> _favoriteCitys = [];

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
  }

  saveUserHistory() {
    userPrefs.saveUserHistory(_searchHistory);
  }

  saveUserFavorite() {
    userPrefs.saveUserFavorites(_favoriteCitys);
  }

  clearFavorites() {
    _favoriteCitys.clear();
    saveUserFavorite();
  }

  clearHistory() {
    _searchHistory.clear();
    saveUserHistory();
  }
}
