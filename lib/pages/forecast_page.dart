import 'package:flutter/material.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({super.key});

  @override
  Widget build(BuildContext context) {
    final forecast =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(forecast["date"]),
      ),
      body: const Column(
        children: [Text("123")],
      ),
    );
  }
}
