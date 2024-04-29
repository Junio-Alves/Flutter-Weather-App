import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:weather_app2/data/utils/constants.dart';
import 'package:weather_app2/data/sharedPreferences/user_preferences.dart';
import '../controller/position_controller.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import "package:http/http.dart" as http;

class WeatherProvider extends ChangeNotifier {
  final positionController = GetPosition();
  final userPrefs = UserPreferences();
  List<WeatherModel> weathers = [];
  //verifica se está carregando
  bool isLoanding = true;
  //erros
  String error = '';

  Future getWeather() async {
    Map<String, dynamic> userWeather = await userPrefs.loadUserLocal();
    log(userWeather.toString());
    //verifica se userWeather é null
    //caso sim, faz uma requisição para API
    if (userWeather.containsKey("null")) {
      try {
        await positionController.getPosition();
        final result = await http.get(Uri.parse(
            'https://api.hgbrasil.com/weather?key=${Constants.api_Key}&lat=${positionController.lat}&lon=${positionController.long}&user_ip=remote'));

        //TRATAMENTO DE ERROS
        if (result.statusCode == 200) {
          weathers.clear();
          final body = jsonDecode(result.body);
          //Caso statusCode seja 200, adiciona o resultado na lista.
          weathers.add(WeatherModel.fromMap(body['results']));
          userPrefs.saveUserLocal(WeatherModel.fromMap(body['results']));
        } else if (result.statusCode == 404) {
          error = result.statusCode.toString();
          throw Exception("A url informada não é valida");
        } else {
          error = result.statusCode.toString();
          throw Exception("Não foi possivel localizar previsão.");
        }
      } catch (e) {
        error = e.toString();
      }
    }
    //caso não seja, utiliza os dados salvos
    else {
      weathers.clear();
      weathers.add(WeatherModel.fromMap(userWeather));
    }

    //define o carregamento como falso.
    isLoanding = false;
    notifyListeners();
  }
}
