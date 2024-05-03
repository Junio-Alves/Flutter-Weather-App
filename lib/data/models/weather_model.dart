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
  //Colocar
  //"humidity": 77,
  /*"cloudiness": 20,
    "rain": 0,
    "wind_speedy": "5.14 km/h",
    "wind_direction": 70,
    "wind_cardinal": "ENE",
    "sunrise": "07:42 am",
    "sunset": "08:52 pm",
    "moon_phase": "last_quarter",
    "condition_slug": "cloudly_night",
    "city_name": "Miami",
    "timezone": "-04:00", */
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
    };
  }
}
