import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/loading_icon.gif",
              scale: 0.7,
            ),
            const Text(
              "Carregando...",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
