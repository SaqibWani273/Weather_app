import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weathe_app/constants/custom_exception.dart';
import 'package:weathe_app/constants/error_type.dart';
import 'package:weathe_app/utils/get_lottie_image.dart';

import '../../view_model/weather_bloc/weather_bloc.dart';

class ErrorScreen extends StatelessWidget {
  final CustomException customException;
  const ErrorScreen({super.key, required this.customException});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          Colors.blue.withOpacity(0.4), // const Color(0xFF87CEFA), //sky blue
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getLottieImage(customException),
            FittedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  customException.message,
                  style: const TextStyle(fontSize: 25),
                  //   overflow: TextOverflow.visible,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (customException.errorType ==
                ErrorType.locationPermissionDeniedPermanently)
              RichText(
                  textAlign: TextAlign.center,
                  textScaler: const TextScaler.linear(1.5),
                  text: TextSpan(children: [
                    const TextSpan(
                        text: "Go to ", style: TextStyle(color: Colors.white)),
                    TextSpan(
                      text: "app Settings",
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await Geolocator.openAppSettings();
                          if (context.mounted) {
                            context
                                .read<WeatherBloc>()
                                .add(FetchCurrentLocationWeather());
                          }
                        },
                    ),
                    const TextSpan(
                        text: " and enable location permission",
                        style: TextStyle(color: Colors.white)),
                  ])),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () async {
                  context
                      .read<WeatherBloc>()
                      .add(FetchCurrentLocationWeather());
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                child: const Text(
                  ' Try Again >> ',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
