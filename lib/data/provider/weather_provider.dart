import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:weather_app2/data/utils/constants.dart';
import '../controller/position_controller.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import "package:http/http.dart" as http;

class WeatherProvider extends ChangeNotifier {
  final positionController = GetPosition();
  List<WeatherModel> weathers = [];
  //verifica se está carregando
  bool isLoanding = true;
  //erros
  String error = '';

  Future getWeather() async {
    try {
      await positionController.getPosition();
      final result = await http.get(Uri.parse(
          'https://api.hgbrasil.com/weather?key=${Constants.api_Key}&lat=${positionController.lat}&lon=${positionController.long}&user_ip=remote'));

      //TRATAMENTO DE ERROS
      if (result.statusCode == 200) {
        final body = jsonDecode(result.body);
        //Caso statusCode seja 200, adiciona o resultado na lista.
        weathers.add(WeatherModel.fromMap(body['results']));
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
    //define o carregamento como falso.
    isLoanding = false;
    notifyListeners();
  }
}
