import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/provider/weather_provider.dart';
import 'package:weather_app2/pages/tabs_screen.dart';
import 'package:weather_app2/data/provider/backgroundcolor_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => WeatherProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => BackgrounColorProvider()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TabScreen(),
      ),
    );
  }
}
