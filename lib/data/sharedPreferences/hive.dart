import 'package:hive/hive.dart';
import 'package:weather_app2/data/models/weather_model.dart';

class UserDataHive {
  final box = Hive.box<List>("User");
  saveUserHistory({required List<dynamic> weather}) {
    box.put("history", weather);
  }

  loadUserHistory() {
    final userHistory = box.get("history");
    if (userHistory != null) {
      //    return WeatherModel.fromMap(userHistory);
    } else {
      return null;
    }
  }
}
