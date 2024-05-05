import 'package:flutter/material.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import 'package:weather_app2/pages/widgets/text_shadow.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final weather = ModalRoute.of(context)!.settings.arguments as WeatherModel;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background/2.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textshadow(
                      text: "${weather.temp}°",
                      fontsize: 50,
                      color: Theme.of(context).secondaryHeaderColor,
                      fontWeight: FontWeight.normal,
                    ),
                    textshadow(
                      text: weather.city,
                      fontsize: 30,
                      color: Theme.of(context).secondaryHeaderColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.announcement_outlined),
            title: const Text("Feedback"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Configurações"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.question_mark),
            title: const Text("Sobre"),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
