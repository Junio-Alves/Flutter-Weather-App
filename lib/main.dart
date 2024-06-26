import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/provider/userData_provider.dart';
import 'package:weather_app2/data/provider/weather_provider.dart';
import 'package:weather_app2/data/utils/appRoutes.dart';
import 'package:weather_app2/pages/drawer/about_page.dart';
import 'package:weather_app2/pages/home/app_drawer_page.dart';
import 'package:weather_app2/pages/drawer/feedback_page.dart';
import 'package:weather_app2/pages/home/forecast_page.dart';
import 'package:weather_app2/pages/home_or_error.dart';
import 'package:weather_app2/pages/option/city_option_page.dart';
import 'package:weather_app2/pages/option/language_page.dart';
import 'package:weather_app2/pages/option/option_page.dart';
import 'package:weather_app2/pages/option/speed_unit.dart';
import 'package:weather_app2/pages/option/temperature_unit.dart';
import 'package:weather_app2/pages/option/theme_page.dart';
import 'package:weather_app2/pages/search_page.dart';
import 'package:weather_app2/pages/select_page.dart';

void main() async {
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
          AppRoutes.selectPage: (context) => const SelectPage(),
          AppRoutes.home: (context) => const HomePage(),
          AppRoutes.optionPage: (context) => const OptionPage(),
          AppRoutes.searchPage: (context) => const SearchPage(),
          AppRoutes.forecastPage: (context) => const ForecastPage(),
          AppRoutes.drawerPage: (context) => const AppDrawer(),
          AppRoutes.feedbackPage: (context) => const FeedbackPage(),
          AppRoutes.aboutPage: (context) => const AboutPage(),
          AppRoutes.languagePage: (context) => const LanguagePage(),
          AppRoutes.speedUnit: (context) => const SpeedUnitPage(),
          AppRoutes.temperatureUnit: (context) => const TemperatureUnitPage(),
          AppRoutes.themePage: (context) => const ThemePage(),
          AppRoutes.cityOptionPage: (context) => const CityOptionPage(),
        },
      ),
    );
  }
}
