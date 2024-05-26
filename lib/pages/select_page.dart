import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/provider/userData_provider.dart';
import 'package:weather_app2/data/provider/weather_provider.dart';
import 'package:weather_app2/data/utils/appRoutes.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    final weather = Provider.of<WeatherProvider>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(5)),
              child: InkWell(
                onTap: () {
                  userData.isntFirstLogin();
                  userData.setCurrentLocation(true);
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                  child: Text(
                    "Usar Localização Atual",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(5)),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.searchPage)
                      .then((value) {
                    if (weather.userweather != null) {
                      userData.isntFirstLogin();
                      userData.setCustomCity(weather.userweather!.city);
                      userData.setCurrentLocation(false);
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    }
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                  child: Text(
                    "Selecionar Cidade",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  optionCard({
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black45, borderRadius: BorderRadius.circular(5)),
        child: InkWell(
          onTap: () {},
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
