import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/provider/weather_provider.dart';
import 'package:weather_app2/data/utils/appRoutes.dart';
import 'package:weather_app2/data/utils/background.dart';
import 'package:weather_app2/data/utils/imageIcon.dart';
import 'package:weather_app2/pages/widgets/draggable_widget.dart';
import 'package:weather_app2/pages/widgets/text_shadow.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherProvider>(context).userweather!;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(background(weather.currently)),
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
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.95,
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
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
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
                          text: weather.date,
                          fontsize: 15,
                          color: Theme.of(context).secondaryHeaderColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                imageIcon(weather.currently),
                                height: 50,
                                width: 50,
                              ),
                              textshadow(
                                text: weather.description,
                                fontsize: 20,
                                color: Theme.of(context).secondaryHeaderColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                          textshadow(
                            text: "${weather.temp}°",
                            fontsize: 90,
                            color: Theme.of(context).secondaryHeaderColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
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
