import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/pages/home_page.dart';
import 'package:weather_app2/pages/search_page.dart';
import 'package:weather_app2/data/provider/backgroundcolor_provider.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final _paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    pc = PageController(initialPage: _paginaAtual);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundProvider =
        Provider.of<BackgrounColorProvider>(context, listen: true);
    return Scaffold(
      body: PageView(
        children: const [HomePage(), SearchPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
