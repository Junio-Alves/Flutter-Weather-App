import 'package:flutter/material.dart';
import 'package:weather_app2/data/provider/userData_provider.dart';
import 'package:weather_app2/data/provider/weather_provider.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/pages/home/weather_page.dart';
import 'package:weather_app2/pages/loading_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  @override
  void initState() {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);

    final userData = Provider.of<UserData>(context, listen: false);
    userData.loadUserData();

    weatherProvider.getLocalWeather().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
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
