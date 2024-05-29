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
        title: const Text("Configurações"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 500,
          decoration: BoxDecoration(
              color: Colors.black54, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              optionCard(
                  text: "Selecionar Linguagem",
                  context: context,
                  route: AppRoutes.languagePage,
                  icon: Icons.language),
              optionCard(
                  text: "Selecionar Tema",
                  context: context,
                  route: AppRoutes.themePage,
                  icon: Icons.color_lens),
              optionCard(
                  text: "Localização",
                  context: context,
                  route: AppRoutes.cityOptionPage,
                  icon: Icons.pin_drop),
              optionCard(
                  text: "Unidade de Temperatura",
                  context: context,
                  route: AppRoutes.temperatureUnit,
                  icon: Icons.thermostat),
              optionCard(
                  text: "Unidade de velocidade do vento ",
                  context: context,
                  route: AppRoutes.speedUnit,
                  icon: Icons.speed),
              optionCard(
                  text: "Tipo de Hora",
                  context: context,
                  route: AppRoutes.speedUnit,
                  icon: Icons.timer),
              optionCard(
                  text: "Notificações",
                  context: context,
                  route: AppRoutes.speedUnit,
                  icon: Icons.notification_important_outlined),
            ],
          ),
        ),
      ),
    );
  }
}

optionCard(
    {required String text,
    required BuildContext context,
    required String route,
    required IconData icon}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  icon,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
}
