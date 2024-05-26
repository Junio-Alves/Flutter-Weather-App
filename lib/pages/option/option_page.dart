import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app2/data/utils/appRoutes.dart';

class OptionPage extends StatefulWidget {
  const OptionPage({super.key});

  @override
  State<OptionPage> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Options"),
      ),
      body: Column(
        children: [
          optionCard(
              text: "Selecionar Linguagem",
              context: context,
              route: AppRoutes.languagePage),
          optionCard(
              text: "Selecionar Tema",
              context: context,
              route: AppRoutes.themePage),
          optionCard(
              text: "Localização",
              context: context,
              route: AppRoutes.cityOptionPage),
          optionCard(
              text: "Unidade de Temperatura",
              context: context,
              route: AppRoutes.temperatureUnit),
          optionCard(
              text: "Unidade de velocidade do vento ",
              context: context,
              route: AppRoutes.speedUnit),
          optionCard(
              text: "Tipo de Hora",
              context: context,
              route: AppRoutes.speedUnit),
          optionCard(
              text: "Notificações",
              context: context,
              route: AppRoutes.speedUnit),
        ],
      ),
    );
  }
}

optionCard(
    {required String text,
    required BuildContext context,
    required String route}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
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
