import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(30)),
            child: Image.asset(
              "assets/icons/white/partlysunny.png",
              scale: 1,
            ),
          ),
          const Text(
              "Para saber como você pode contribuir com o \nprojeto, confira o projeto no GitHub.")
        ],
      ),
    );
  }
}
