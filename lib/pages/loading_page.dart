import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/provider/backgroundcolor_provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundProvider =
        Provider.of<BackgrounColorProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: backgroundProvider.backgroundColor,
      body: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitCircle(
              color: Colors.blue,
              size: 50,
            )
          ],
        ),
      ),
    );
  }
}
