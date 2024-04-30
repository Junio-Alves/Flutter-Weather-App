import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/provider/weather_provider.dart';
import 'package:weather_app2/data/provider/backgroundcolor_provider.dart';
import 'package:weather_app2/data/utils/appRoutes.dart';
import 'package:weather_app2/pages/option_page.dart';
import 'package:weather_app2/pages/search_page.dart';
import 'package:weather_app2/pages/tabs_screen.dart';

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
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.home: (context) => const TabScreen(),
          AppRoutes.option_page: (context) => const OptionPage(),
          AppRoutes.search_page: (context) => const SearchPage(),
        },
      ),
    );
  }
}
