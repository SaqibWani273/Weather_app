import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weathe_app/view/weather_bloc/weather_bloc.dart';

const dummy =
    'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherInitialState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is WeatherLoadedState) {
          log("data is loaded");
          //   return Image.network(state.weatherModel.imageUrl)
          return Stack(children: [
            Image.network(state.weatherModel.imageUrl),
            Lottie.network(dummy),
          ]);
        }

        if (state is WeatherErrorState) {
          return Center(
            child: Text(
              " ${state.error!} ",
              overflow: TextOverflow.visible,
            ),
          );
        } else {
          return const Center(
            child: Text("neither success nor initial state"),
          );
        }
      },
    );
  }
}
