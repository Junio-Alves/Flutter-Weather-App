import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import 'package:weather_app2/data/provider/backgroundcolor_provider.dart';
import 'package:weather_app2/pages/widgets/draggable_widget.dart';

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
    // ignore: unused_local_variable
    final backgroundProvider = Provider.of<BackgrounColorProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/background/1.png"),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              //NOME DA CIDADE
                              weather.city,
                              style: TextStyle(
                                  shadows: const [
                                    Shadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 10.0,
                                      color: Colors.black38,
                                    ),
                                  ],
                                  fontSize: 30,
                                  color: Theme.of(context).secondaryHeaderColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.add_location_rounded,
                              color: Theme.of(context).secondaryHeaderColor,
                              weight: 50,
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            color: Colors.white,
                            icon: const Icon(Icons.table_rows_rounded))
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          //DESCRIÇÃO DO TEMPO E DATA
                          "${weather.description}  ${weather.date}",
                          style: TextStyle(
                              shadows: const [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 10.0,
                                  color: Colors.black38,
                                ),
                              ],
                              fontSize: 15,
                              color: Theme.of(context).secondaryHeaderColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Row(
                        children: [
                          Text(
                            //TEMPERATURA
                            "${weather.temp}°",
                            style: TextStyle(
                              shadows: const [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 10.0,
                                  color: Colors.black38,
                                ),
                              ],
                              fontSize: 90,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //ICONE DO TEMPO ATUAL
                        //Image.asset(
                        //  imageIcon(weather.currently),
                        //  height: 200,
                        //  width: 200,
                        //)
                      ],
                    ),
                  ],
                ),
              ),
              DraggableWidget(weather: weather),
            ],
          ),
        ],
      ),
    );
  }
}
