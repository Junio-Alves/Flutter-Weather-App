import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:weather_app2/data/utils/constants.dart';
import '../controller/user_geolocator.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import "package:http/http.dart" as http;

class WeatherProvider extends ChangeNotifier {
  final position = GeoLocation();
  WeatherModel? _localUserWeather;
  WeatherModel? _searchWeather;
  String error = '';

  WeatherModel? get userweather => _localUserWeather;

  WeatherModel? get resultWeather => _searchWeather;

  //Altera o clima do usuário por um novo
  changeWeather({required WeatherModel newWeather}) {
    _localUserWeather = newWeather;
    notifyListeners();
  }

  //Busca um clima com base na geolocalização do usuário.
  Future getLocalWeather() async {
    try {
      await position.getPosition();
      final result = await http.get(
        Uri.parse(
          Constants.api(lat: position.lat, long: position.long),
        ),
      );
      log(result.body);
      if (result.statusCode == 200) {
        final body = jsonDecode(result.body);
        _localUserWeather = WeatherModel.fromMap(body["results"]);
        return _localUserWeather;
      } else {
        error = result.statusCode.toString();
        throw Exception("Erro na requisição: $error");
      }
    } catch (e) {
      error = e.toString();
    }

    notifyListeners();
  }

  //Busca um clima com base no nome da cidade fornecido
  Future searchWeather({required String cityname}) async {
    error = "";
    try {
      final result = await http.get(
        Uri.parse(
            "https://api.hgbrasil.com/weather?key=${Constants.apiKey}&city_name=$cityname"),
      );
      log(result.body);
      if (result.statusCode == 200) {
        final body = jsonDecode(result.body);
        if (body["by"] == "city_name") {
          _searchWeather = WeatherModel.fromMap(body["results"]);
          return _searchWeather;
        } else if (body["by"] == "default") {
          error =
              "A cidade digitada não foi localizada. Por favor, verifique a ortografia e tente novamente.";
        }
      } else {
        error = "Erro na requisição da API";
      }
    } catch (e) {
      error = error.toString();
    }
    notifyListeners();
  }

  clearSearchResult() {
    _searchWeather = null;
  }
}
