import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import 'package:weather_app2/data/provider/backgroundcolor_provider.dart';
import 'package:weather_app2/data/utils/appRoutes.dart';
import 'package:weather_app2/pages/widgets/draggable_widget.dart';
import 'package:weather_app2/pages/widgets/text_shadow.dart';

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
                            textshadow(
                              text: weather.city,
                              fontsize: 30,
                              color: Theme.of(context).secondaryHeaderColor,
                              fontWeight: FontWeight.bold,
                            ),
                            Icon(
                              Icons.add_location_rounded,
                              color: Theme.of(context).secondaryHeaderColor,
                              weight: 50,
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.drawer_page,
                                  arguments: weather);
                            },
                            color: Colors.white,
                            icon: const Icon(Icons.table_rows_rounded))
                      ],
                    ),
                    Row(
                      children: [
                        textshadow(
                          text: "${weather.description}  ${weather.date}",
                          fontsize: 15,
                          color: Theme.of(context).secondaryHeaderColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Row(
                        children: [
                          textshadow(
                            text: "${weather.temp}°",
                            fontsize: 90,
                            color: Theme.of(context).secondaryHeaderColor,
                            fontWeight: FontWeight.normal,
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
