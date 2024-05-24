import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/provider/userData_provider.dart';

class TemperatureUnitPage extends StatefulWidget {
  const TemperatureUnitPage({super.key});

  @override
  State<TemperatureUnitPage> createState() => _TemperatureUnitPageState();
}

class _TemperatureUnitPageState extends State<TemperatureUnitPage> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Temperature Unit"),
      ),
      body: Column(
        children: [
          RadioListTile(
            title: const Text("Fahrenheit"),
            value: "Fahrenheit",
            groupValue: userData.selectedTemperature,
            onChanged: (value) {
              setState(() {
                userData.updateUserTemperature(value.toString());
              });
            },
          ),
          RadioListTile(
            title: const Text("Celsius"),
            value: "Celsius",
            groupValue: userData.selectedTemperature,
            onChanged: (value) {
              setState(() {
                userData.updateUserTemperature(value.toString());
              });
            },
          ),
          RadioListTile(
            title: const Text("Kelvin"),
            value: "Kelvin",
            groupValue: userData.selectedTemperature,
            onChanged: (value) {
              setState(() {
                userData.updateUserTemperature(value.toString());
              });
            },
          ),
        ],
      ),
    );
  }
}
