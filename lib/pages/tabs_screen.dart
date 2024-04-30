import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/pages/home_page.dart';
import 'package:weather_app2/pages/option_page.dart';
import 'package:weather_app2/pages/search_page.dart';
import 'package:weather_app2/data/provider/backgroundcolor_provider.dart';
import 'package:weather_app2/pages/widgets/app_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

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
    _paginaAtual = value;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundProvider =
        Provider.of<BackgrounColorProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundProvider.backgroundColor,
      ),
      drawer: const AppDrawer(),
      body: PageView(
        children: const [
          HomePage(),
          SearchPage(),
          OptionPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        iconSize: 40,
        backgroundColor: backgroundProvider.backgroundColor,
        currentIndex: _paginaAtual,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        items: const [
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.home,
                color: Colors.white,
                weight: 30,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.format_align_justify_sharp,
                color: Colors.white,
              ),
              label: "Option"),
        ],
      ),
    );
  }
}
