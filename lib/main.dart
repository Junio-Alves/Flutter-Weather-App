import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/provider/weather_provider.dart';
import 'package:weather_app2/pages/home_page.dart';
import 'package:weather_app2/pages/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

Color? color;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => WeatherProvider()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const TabScreen(),
        theme: ThemeData(scaffoldBackgroundColor: color),
      ),
    );
  }
}
