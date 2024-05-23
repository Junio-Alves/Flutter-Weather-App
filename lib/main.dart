import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/provider/userData_provider.dart';
import 'package:weather_app2/data/provider/weather_provider.dart';
import 'package:weather_app2/data/utils/appRoutes.dart';
import 'package:weather_app2/pages/drawer/about_page.dart';
import 'package:weather_app2/pages/home/app_drawer_page.dart';
import 'package:weather_app2/pages/drawer/feedback_page.dart';
import 'package:weather_app2/pages/home/forecast_page.dart';
import 'package:weather_app2/pages/home_or_error.dart';
import 'package:weather_app2/pages/option/language_page.dart';
import 'package:weather_app2/pages/option/option_page.dart';
import 'package:weather_app2/pages/option/speed_unit.dart';
import 'package:weather_app2/pages/option/temperature_unit.dart';
import 'package:weather_app2/pages/option/theme_page.dart';
import 'package:weather_app2/pages/search_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<List>("User");
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
          create: ((context) => UserData()),
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
          AppRoutes.forecast_page: (context) => const ForecastPage(),
          AppRoutes.drawer_page: (context) => const AppDrawer(),
          AppRoutes.feedback_page: (context) => const FeedbackPage(),
          AppRoutes.about_page: (context) => const AboutPage(),
          AppRoutes.language_page: (context) => const LanguagePage(),
          AppRoutes.speed_unit: (context) => const SpeedUnitPage(),
          AppRoutes.temperature_unit: (context) => const TemperatureUnitPage(),
          AppRoutes.theme_page: (context) => const ThemePage(),
        },
      ),
    );
  }
}
