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
        leading: IconButton(
            onPressed: () {
              if (userData.useCurrentLocation == false &&
                      userData.customCity == null ||
                  userData.customCity == "") {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text(
                          "Deseja Realmente sair? Nenhuma cidade selecionada!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancelar"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(
                                context, AppRoutes.optionPage);
                            userData.setCurrentLocation(true);
                          },
                          child: const Text("Ok"),
                        ),
                      ],
                    );
                  },
                );
              } else {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.arrow_back)),
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
                if (userData.customCity != null && userData.customCity != "") {
                  weather
                      .searchWeather(cityname: userData.customCity)
                      .then((value) {
                    weather.changeWeather(newWeather: weather.resultWeather!);
                  });
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
                              weather.changeWeather(
                                  newWeather: weather.resultWeather!);
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
