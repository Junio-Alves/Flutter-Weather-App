import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/provider/weather_provider.dart';
import 'package:weather_app2/data/provider/backgroundcolor_provider.dart';
import 'package:weather_app2/data/utils/appRoutes.dart';
import 'package:weather_app2/pages/home_or_error.dart';
import 'package:weather_app2/pages/option_page.dart';
import 'package:weather_app2/pages/search_page.dart';

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
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 28, 56, 99),
            secondaryHeaderColor: Colors.white),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.home: (context) => const HomePage(),
          AppRoutes.option_page: (context) => const OptionPage(),
          AppRoutes.search_page: (context) => const SearchPage(),
        },
      ),
    );
  }
}
