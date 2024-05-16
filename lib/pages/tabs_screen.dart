import 'package:flutter/material.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import 'package:weather_app2/pages/option/option_page.dart';
import 'package:weather_app2/pages/search_page.dart';
import 'package:weather_app2/pages/home/weather_page.dart';

class TabScreen extends StatefulWidget {
  final WeatherModel weather;
  const TabScreen({super.key, required this.weather});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    pc = PageController(initialPage: _paginaAtual);
    super.initState();
  }

  void _selectScreen(int value) {
    setState(() {
      _paginaAtual = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _telas = [
      const WeatherPage(),
      const SearchPage(),
      const OptionPage(),
    ];
    return Scaffold(
      body: _telas[_paginaAtual],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        iconSize: 25,
        backgroundColor: Colors.white,
        currentIndex: _paginaAtual,
        unselectedItemColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).primaryColor,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        items: [
          //Home
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.home,
                color: Theme.of(context).primaryColor,
                weight: 30,
              ),
              label: "Home"),
          //Search
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
              label: "Search"),
          //Option
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).primaryColor,
              ),
              label: "Option"),
        ],
      ),
    );
  }
}
