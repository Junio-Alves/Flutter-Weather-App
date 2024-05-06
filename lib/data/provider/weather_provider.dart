import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:weather_app2/data/utils/constants.dart';
import 'package:weather_app2/data/sharedPreferences/user_preferences.dart';
import '../controller/user_geolocator.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import "package:http/http.dart" as http;

class WeatherProvider extends ChangeNotifier {
  final position = GetGeoLocation();
  final userPrefs = UserPreferences();
  final _currentDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
  List<WeatherModel> weathers = [];
  String error = '';

  //*Função getWeather faz uma requisição na API, e salva os dados em "weathers"
  Future getWeather() async {
    Map<String, dynamic> userWeather = await userPrefs.loadUserData();
    log(userWeather.toString());
    log(_currentDate);

    //*Verifica se existe algum dado salvo no dispostivo, caso o valor neja null
    // faz uma nova requisição na API.
    //*Verifica tambem se ja passou 24hrs desde a primeira requisição na API,
    // caso sim, faz uma nova requisição na API.

    if (weathers.isEmpty) {
      try {
        await position.getPosition();
        final result = await http.get(
          Uri.parse(
            Constants.api(lat: position.lat, long: position.long),
          ),
        );
        if (result.statusCode == 200) {
          final body = jsonDecode(result.body);
          weathers.add(WeatherModel.fromMap(body['results']));
          userPrefs.saveUserLocal(WeatherModel.fromMap(body['results']));
        } else {
          error = result.statusCode.toString();
          throw Exception("Erro na requisição: $error");
        }
      } catch (e) {
        error = e.toString();
      }
    }
    //Caso tenha algum dado salvo no disposito,utiliza os dados salvos.
    else {
      weathers.add(WeatherModel.fromMap(userWeather));
    }
    notifyListeners();
  }
}
