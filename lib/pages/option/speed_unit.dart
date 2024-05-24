import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/provider/userData_provider.dart';

class SpeedUnitPage extends StatefulWidget {
  const SpeedUnitPage({super.key});

  @override
  State<SpeedUnitPage> createState() => _SpeedUnitPageState();
}

class _SpeedUnitPageState extends State<SpeedUnitPage> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Speed Unit "),
      ),
      body: Column(
        children: [
          RadioListTile(
            title: const Text("Km/h"),
            value: "Km/h",
            groupValue: userData.selectedTemperature,
            onChanged: (value) {
              setState(() {
                userData.updateUserSpeed(value.toString());
              });
            },
          ),
          RadioListTile(
            title: const Text("Mp/h"),
            value: "Mp/h",
            groupValue: userData.selectedTemperature,
            onChanged: (value) {
              setState(() {
                userData.updateUserSpeed(value.toString());
              });
            },
          ),
          RadioListTile(
            title: const Text("M/s"),
            value: "M/s",
            groupValue: userData.selectedTemperature,
            onChanged: (value) {
              setState(() {
                userData.updateUserSpeed(value.toString());
              });
            },
          )
        ],
      ),
    );
  }
}
