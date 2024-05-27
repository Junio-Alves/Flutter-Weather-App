import 'dart:developer';

class WeatherModel {
  bool isFavorite = false;
  String temp;
  String date;
  String time;
  String description;
  String currently;
  String city;
  String humidity;
  String conditionSlug;
  List<dynamic> forecast;
  WeatherModel({
    required this.temp,
    required this.date,
    required this.time,
    required this.description,
    required this.currently,
    required this.city,
    required this.humidity,
    required this.forecast,
    required this.conditionSlug,
  });

  factory WeatherModel.fromMap(Map<dynamic, dynamic> map) {
    log("modelo: ${map.toString()}");
    return WeatherModel(
      conditionSlug: map["condition_slug"],
      temp: map['temp'].toString(),
      date: map['date'],
      time: map['time'],
      description: map['description'].toString(),
      currently: map['currently'].toString(),
      city: map['city'].toString(),
      humidity: map['humidity'].toString(),
      forecast: map['forecast'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'temp': temp,
      'date': date,
      'time': time,
      'description': description,
      'currently': currently,
      'city': city,
      'humidity': humidity,
      'forecast': forecast,
      'condition_slug': conditionSlug,
    };
  }
}
