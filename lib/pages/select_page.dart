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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/others/island_4773915.png",
              height: 150,
              width: 150,
            ),
            const Text(
              "Selecionar Cidade",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87),
            ),
            const SizedBox(
              height: 100,
            ),
            selectCard(
              onTap: () {
                userData.isntFirstLogin();
                userData.setCurrentLocation(true);
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
              text: "Usar Localização Atual",
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 3, 168, 11),
            ),
            selectCard(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.searchPage).then(
                    (value) {
                      if (weather.userweather != null) {
                        userData.isntFirstLogin();
                        userData.setCustomCity(value.toString());
                        userData.setCurrentLocation(false);
                        Navigator.pushReplacementNamed(context, AppRoutes.home);
                      }
                    },
                  );
                },
                text: "Selecionar Cidade",
                fontWeight: FontWeight.normal,
                color: Colors.black45),
          ],
        ),
      ),
    );
  }

  Widget selectCard({
    required void Function()? onTap,
    required String text,
    required FontWeight fontWeight,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.60,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: fontWeight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
