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
  //Lista de climas;
  List<WeatherModel> weathers = [];
  //erros
  String error = '';

  //*Função getWeather faz uma requisição na API, e salva os dados em "weathers"
  Future getWeather() async {
    Map<String, dynamic> userWeather = await userPrefs.loadUserData();
    log(userWeather.toString());
    //*Verifica se existe algum dado salvo no dispostivo, caso o valor neja null
    // faz uma nova requisição na API.

    //*Verifica tambem se ja passou 24hrs desde a primeira requisição na API,
    // caso sim, faz uma nova requisição na API.

    if (userWeather.containsKey("null") &&
        userWeather["date"] != _currentDate) {
      try {
        position.getPosition().then(
          (value) async {
            final result = await http.get(
              Uri.parse(
                Constants.api(position.lat, position.long),
              ),
            );
            log(result.toString());
            //TRATAMENTO DE ERROS
            //STATUS CODE 200: TUDO OK
            if (result.statusCode == 200) {
              weathers.clear();
              final body = jsonDecode(result.body);
              //Adiciona o resultado na lista Weathers.
              weathers.add(WeatherModel.fromMap(body['results']));
              userPrefs.saveUserLocal(WeatherModel.fromMap(body['results']));
            }
            //STATUS CODE 404: ERRO NA REQUISIÇÃO
            else if (result.statusCode == 404) {
              error = result.statusCode.toString();
              throw Exception("A url informada não é valida");
            } else {
              error = result.statusCode.toString();
              throw Exception("Não foi possivel localizar previsão.");
            }
          },
        );
      } catch (e) {
        error = e.toString();
      }
    }
    //Caso tenha algum dado salvo no disposito,utiliza os dados salvos.
    else {
      weathers.clear();
      weathers.add(WeatherModel.fromMap(userWeather));
    }
    notifyListeners();
  }
}
