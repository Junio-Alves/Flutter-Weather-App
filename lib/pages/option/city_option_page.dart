import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/provider/userData_provider.dart';
import 'package:weather_app2/data/provider/weather_provider.dart';
import 'package:weather_app2/data/utils/appRoutes.dart';

class CityOptionPage extends StatefulWidget {
  const CityOptionPage({super.key});

  @override
  State<CityOptionPage> createState() => _CityOptionPageState();
}

class _CityOptionPageState extends State<CityOptionPage> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    final weather = Provider.of<WeatherProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("City Option Page"),
      ),
      body: Column(
        children: [
          const Text("Usar localização do dispositivo para encontrar clima?"),
          RadioListTile<bool>(
            title: const Text("Sim"),
            value: true,
            groupValue: userData.useCurrentLocation,
            onChanged: (bool? value) {
              setState(() {
                weather.getLocalWeather();
                userData.setCurrentLocation(value!);
              });
            },
          ),
          RadioListTile<bool>(
            title: const Text("Não"),
            value: false,
            groupValue: userData.useCurrentLocation,
            onChanged: (bool? value) {
              setState(() {
                userData.setCurrentLocation(value!);
                if (userData.customCity != null) {
                  weather.searchWeather(cityname: userData.customCity);
                  weather.changeWeather(weather.resultWeather!);
                }
              });
            },
          ),
          if (userData.useCurrentLocation == false)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.black45,
                ),
                child: Row(
                  children: [
                    if (userData.customCity != null) Text(userData.customCity),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.searchPage)
                              .then((value) {
                            setState(() {
                              userData.setCustomCity(value.toString());
                              weather.searchWeather(cityname: value.toString());
                              weather.changeWeather(weather.resultWeather!);
                            });
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [Text("Procurar Cidade")],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
