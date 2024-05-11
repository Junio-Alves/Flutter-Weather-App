import 'dart:convert';
import 'package:weather_app2/data/models/weather_model.dart';
import "package:http/http.dart" as http;
import 'package:weather_app2/data/utils/constants.dart';

class SearchWeather {
  String error = "";

  Future getWeather({required String cityname}) async {
    error = "";
    try {
      final result = await http.get(
        Uri.parse(
            "https://api.hgbrasil.com/weather?key=${Constants.apiKey}&city_name=$cityname"),
      );
      if (result.statusCode == 200) {
        final body = jsonDecode(result.body);
        if (body["by"] == "city_name") {
          return WeatherModel.fromMap(body["results"]);
        } else if (body["by"] == "default") {
          error = "Cidade não encontrada";
        }
      } else {
        error = "Erro na requisição da API";
      }
    } catch (e) {
      error = error.toString();
    }
  }
}
