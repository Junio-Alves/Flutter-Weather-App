import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/provider/userData_provider.dart';
import 'package:weather_app2/data/utils/imageIcon.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({super.key});

  @override
  Widget build(BuildContext context) {
    final forecast =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final userData = Provider.of<UserData>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        " ${forecast["weekday"]} ${forecast["date"]}",
        style: const TextStyle(fontSize: 20),
      )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                imageIcon(forecast["condition"]),
                scale: 0.7,
                height: 150,
                width: 150,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                forecastCard(
                    text1: "Max: ",
                    text2: userData
                        .getConvertedTemperature(forecast["max"].toString()),
                    width: 190,
                    fontsize: 20,
                    icon: Icons.arrow_upward_outlined,
                    iconColor: Colors.green),
                forecastCard(
                    text1: "Min: ",
                    text2: userData
                        .getConvertedTemperature(forecast["min"].toString()),
                    width: 190,
                    fontsize: 20,
                    icon: Icons.arrow_downward,
                    iconColor: Colors.red),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                forecastCard(
                    text1: "Nebulosidade:",
                    text2: "${forecast["cloudiness"].toString()}%",
                    width: 190,
                    fontsize: 17,
                    icon: Icons.cloud,
                    iconColor: Colors.black),
                forecastCard(
                    text1: "Chuva",
                    text2: "${forecast["rain"].toString()}mm",
                    width: 190,
                    fontsize: 17,
                    icon: Icons.storm,
                    iconColor: Colors.black),
              ],
            ),
            forecastCard(
                text1: "Probabilidade de Chuva:",
                text2: "${forecast["rain_probability"]}%",
                width: 390,
                fontsize: 17,
                icon: Icons.ac_unit,
                iconColor: Colors.black),
            forecastCard(
                text1: "Velocidade dos ventos:",
                text2: userData.getConvertedSpeed(forecast["wind_speedy"]),
                width: 390,
                fontsize: 17,
                icon: Icons.speed,
                iconColor: Colors.black),
            forecastCard(
                text1: "Descrição:",
                text2: "${forecast["description"]}",
                width: 390,
                fontsize: 17,
                icon: Icons.mark_chat_read_sharp,
                iconColor: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget forecastCard(
      {required String text1,
      required String text2,
      required double width,
      required double fontsize,
      required IconData icon,
      required Color iconColor}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 70,
        width: width,
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            Text(
              "$text1 $text2",
              style: TextStyle(fontSize: fontsize, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
