import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import 'package:weather_app2/data/utils/imageIcon.dart';

class DraggableWidget extends StatefulWidget {
  final WeatherModel weather;
  const DraggableWidget({
    super.key,
    required this.weather,
  });

  @override
  State<DraggableWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  @override
  Widget build(BuildContext context) {
    WeatherModel weather = widget.weather;
    return Expanded(
      child: DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.2,
        maxChildSize: 0.7,
        builder: (context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      constraints: const BoxConstraints(
                        maxHeight: 200,
                        maxWidth: 400,
                      ),
                      child:
                          //CARD COM A PREVISÃO DOS DIAS SEGUINTES
                          ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: weather.forecast.length,
                              itemBuilder: (context, int index) {
                                return InkWell(
                                  onTap: () {
                                    log(index.toString());
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 23, top: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                  color: Theme.of(context)
                                                      .primaryColor,
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
                                                  color: Theme.of(context)
                                                      .primaryColor,
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
                  const Row(
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
