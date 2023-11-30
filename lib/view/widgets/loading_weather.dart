import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWeather extends StatelessWidget {
  const LoadingWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue.withOpacity(0.4),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                //to do : get from firestore later
                Lottie.asset("assets/lottie/loading_weather.json",
                    fit: BoxFit.cover),
                const SizedBox(
                  height: 30,
                ),
                const Text("Loading Weather Data ... "),
              ]),
        ));
  }
}
