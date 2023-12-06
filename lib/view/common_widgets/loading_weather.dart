import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWeather extends StatefulWidget {
  const LoadingWeather({super.key});

  @override
  State<LoadingWeather> createState() => _LoadingWeatherState();
}

class _LoadingWeatherState extends State<LoadingWeather>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _animation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(animationController);

    // Start the animation
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

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
                ScaleTransition(
                  scale: _animation,
                  child: Image.asset(
                    "assets/images/splash_img_nobg.png",
                  ),
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
