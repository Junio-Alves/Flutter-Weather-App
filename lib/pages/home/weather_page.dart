import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app2/data/models/weather_model.dart';
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
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.search_page);
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              "Procurar Cidade",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                color: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.drawer_page,
                                        arguments: weather);
                                  },
                                  icon: const Icon(
                                    Icons.table_rows_rounded,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
