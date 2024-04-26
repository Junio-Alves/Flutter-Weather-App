import 'package:flutter/material.dart';
import 'package:weather_app2/pages/home_page.dart';
import 'package:weather_app2/pages/search_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [HomePage(), SearchPage()],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          elevation: 30,
          iconSize: 40,
          backgroundColor: Colors.grey.withOpacity(0.3),
          currentIndex: _paginaAtual,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                  weight: 30,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.format_align_justify_sharp,
                  color: Colors.white,
                ),
                label: ""),
          ],
        ),
      ),
    );
  }
}
