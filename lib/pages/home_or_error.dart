import 'package:flutter/material.dart';
import 'package:weather_app2/data/provider/userData_provider.dart';
import 'package:weather_app2/data/provider/weather_provider.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/utils/appRoutes.dart';
import 'package:weather_app2/pages/home/weather_page.dart';
import 'package:weather_app2/pages/loading_page.dart';
import 'package:weather_app2/pages/widgets/popUpError_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  @override
  void initState() {
    _initialize();
    super.initState();
  }

  Future _initialize() async {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    final userData = Provider.of<UserData>(context, listen: false);
    await userData.loadUserData();
    try {
      if (userData.isFirstLogin) {
        _navigateToSelectPage();
      } else if (userData.useCurrentLocation) {
        await _getLocalWeather(weatherProvider: weatherProvider);
        setState(() {
          _isLoading = false;
        });
      } else {
        await _getCustomWeather(
            weatherProvider: weatherProvider, userData: userData);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      if (mounted) {
        errorPopUpWidget(error.toString(), context, () {
          Navigator.pop(context);
        });
      }
    }
  }

  _navigateToSelectPage() {
    Navigator.pushReplacementNamed(context, AppRoutes.selectPage);
  }

  _getLocalWeather({required WeatherProvider weatherProvider}) async {
    await weatherProvider.getLocalWeather();
  }

  _getCustomWeather(
      {required WeatherProvider weatherProvider,
      required UserData userData}) async {
    weatherProvider.changeWeather(
        newWeather:
            await weatherProvider.searchWeather(cityname: userData.customCity));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context, listen: false);
    return Scaffold(
      body: _isLoading
          ? const LoadingPage()
          : provider.error.isNotEmpty
              ? getErrorUI(provider.error)
              : const WeatherPage(),
    );
  }

  //Tela de Erro
  Widget getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 50),
      ),
    );
  }
}
