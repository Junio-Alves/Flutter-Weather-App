import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import 'package:weather_app2/data/provider/weather_provider.dart';
import 'package:weather_app2/pages/widgets/backgroundcolor.dart';
import 'package:weather_app2/pages/widgets/imageIcon.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  @override
  void initState() {
    final provider = Provider.of<WeatherProvider>(context, listen: false);
    provider.getWeather().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.toc_outlined),
            color: Colors.white,
            iconSize: 40,
          )
        ],
      ),
      body: _isLoading
          ? getLoadingUI()
          : provider.error.isNotEmpty
              ? getErrorUI(provider.error)
              : getBodyUI(provider.weathers),
    );
  }

  //Tela de carregamento
  Widget getLoadingUI() {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitCircle(
            color: Colors.blue,
            size: 50,
          )
        ],
      ),
    );
  }

  //Tela de Erro
  Widget getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 50),
      ),
    );
  }

  Widget getBodyUI(List<WeatherModel> weathers) {
    WeatherModel weather = weathers[0];

    return Column(
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
                "${weather.temp}°",
                style: const TextStyle(
                  fontSize: 90,
                  color: Colors.white,
                ),
              ),
              Text(
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
        const SizedBox(
          height: 30,
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
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 10, top: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.asset(
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
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
