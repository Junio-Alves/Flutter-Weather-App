import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  colors: backgroundProvider.gradientBackgroundColor(weather),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Text(
                                //NOME DA CIDADE
                                weather.city,
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.add_location_rounded,
                                color: Theme.of(context).primaryColor,
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
                                style: TextStyle(
                                  fontSize: 90,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Text(
                                //DESCRIÇÃO DO TEMPO E DATA
                                "${weather.description}  ${weather.date}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //ICONE DO TEMPO ATUAL
                            Image.asset(
                              imageIcon(weather.currently),
                              height: 200,
                              width: 200,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //CARD COM A PREVISÃO DOS DIAS SEGUINTES
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(19.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        //ICONE(DIA OU NOITE)
                                        imageIcon(weather.forecast[index]
                                            ["condition"]),
                                        height: 40,
                                        width: 40,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${weather.forecast[index]["weekday"]}',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${weather.forecast[index]["date"]}',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 20),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Maxima",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Minima",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            children: [
                              Text(
                                " Probabilidade de Chuva",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Velocidade dos Ventos",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
