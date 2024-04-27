import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import 'package:weather_app2/data/provider/backgroundcolor_provider.dart';
import 'package:weather_app2/data/utils/imageIcon.dart';

class WeatherPage extends StatefulWidget {
  final WeatherModel weather;
  const WeatherPage({super.key, required this.weather});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    WeatherModel weather = widget.weather;
    final backgroundProvider = Provider.of<BackgrounColorProvider>(context);
    return Scaffold(
      backgroundColor: backgroundProvider.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  //NOME DA CIDADE
                  weather.city,
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.add_location_rounded,
                  color: Colors.white,
                  weight: 50,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Row(
              children: [
                Text(
                  //TEMPERATURA
                  "${weather.temp}°",
                  style: const TextStyle(
                    fontSize: 90,
                    color: Colors.white,
                  ),
                ),
                Text(
                  //DESCRIÇÃO DO TEMPO E DATA
                  "${weather.description}  ${weather.date}",
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageIcon(weather.currently),
                height: 200,
                width: 200,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: 150,
              constraints: const BoxConstraints(
                maxHeight: 200,
                maxWidth: 400,
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: weather.forecast.length,
                  itemBuilder: (context, int index) {
                    return Card(
                      color: Colors.grey.withOpacity(0.3),
                      elevation: 9,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  //ICONE(DIA OU NOITE)
                                  imageIcon(
                                      weather.forecast[index]["condition"]),
                                  height: 30,
                                  width: 30,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${weather.forecast[index]["weekday"]}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${weather.forecast[index]["date"]}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
