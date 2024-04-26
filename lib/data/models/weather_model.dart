class WeatherModel {
  //Temperatura
  String temp;
  //Data
  String date;
  //Tempo
  String time;
  //Descricão
  String description;
  //Dia ou noite
  String currently;
  //Cidade
  String city;
  //Humidade
  String humidity;
  //Lista de previsoões dos proximos dias
  List<dynamic> forecast;

  WeatherModel(
      {required this.temp,
      required this.date,
      required this.time,
      required this.description,
      required this.currently,
      required this.city,
      required this.humidity,
      required this.forecast});

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      temp: map['temp'].toString(),
      date: map['date'].toString(),
      time: map['time'].toString(),
      description: map['description'].toString(),
      currently: map['currently'].toString(),
      city: map['city'].toString(),
      humidity: map['humidity:'].toString(),
      forecast: map['forecast'],
    );
  }
}
