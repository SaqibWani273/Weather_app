import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWeather extends StatelessWidget {
  const LoadingWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.blue.withOpacity(0.4),
        color: Color.fromARGB(255, 16, 12, 44),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                //to do : get from firestore later
                // Lottie.asset("assets/lottie/loading_weather.json",
                //     fit: BoxFit.cover),
                Image.asset(
                  "assets/images/splash_img_nobg.png",
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) {
                      return child;
                    }
                    return AnimatedOpacity(
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      child: child,
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("Loading Weather Data ... "),
                SizedBox(
                  height: 10,
                ),
                const CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              ]),
        ));
  }
}
