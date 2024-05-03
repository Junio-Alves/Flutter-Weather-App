import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/provider/backgroundcolor_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundProvider =
        Provider.of<BackgrounColorProvider>(context, listen: true);
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          AppBar(
            title: const Text(
              "Weather App v1 ",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            backgroundColor: backgroundProvider.backgroundColor,
          ),
          ListTile(
            leading: const Icon(Icons.supervised_user_circle),
            title: const Text("Perfil"),
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
