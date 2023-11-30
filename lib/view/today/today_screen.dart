import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe_app/view/widgets/error_screen.dart';
import 'package:weathe_app/view/widgets/loading_weather.dart';

import '../../view_model/weather_bloc/weather_bloc.dart';
import 'widgets/loaded_today_widget.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
// const dummy =
//     'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitialState) {
            // return Container(
            //   color: Color.fromRGBO(13, 117, 248, 1.0),
            //   child: const Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // );
            return LoadingWeather();
          }
          if (state is LoadingWeatherState) {
            return LoadingWeather();
            // return Container(
            //     color: Color.fromRGBO(13, 117, 248, 1.0),
            //     child: const Center(
            //       child: Text("Loading Weather"),
            //     ));
          }
          if (state is WeatherLoadedState) {
            log("data is loaded successfully in ui");
            //   return Image.network(state.weatherModel.imageUrl)

            return LoadedTodayWidget(
              state: state,
            );
          }

          if (state is WeatherErrorState) {
            return ErrorScreen(
              customException: state.error,
            );
          } else {
            return Container(
              color: Color.fromRGBO(13, 117, 248, 1.0),
              child: const Center(
                child: Text("neither success nor initial state"),
              ),
            );
          }
        },
      ),
    );
  }
}
