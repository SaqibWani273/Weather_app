import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/weather_bloc/weather_bloc.dart';
import '../widgets/loaded_weather_widget.dart';

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
            return Container(
              color: Color.fromRGBO(13, 117, 248, 1.0),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is LoadingWeatherState) {
            return Container(
                color: Color.fromRGBO(13, 117, 248, 1.0),
                child: const Center(
                  child: Text("Loading Weather"),
                ));
          }
          if (state is WeatherLoadedState) {
            log("data is loaded successfully in ui");
            //   return Image.network(state.weatherModel.imageUrl)

            return LoadedTodayWidget(
              state: state,
            );
          }

          if (state is WeatherErrorState) {
            return Container(
              color: Color.fromRGBO(13, 117, 248, 1.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " ${state.error!} ",
                      overflow: TextOverflow.visible,
                    ),
                    TextButton(
                        onPressed: () {
                          context
                              .read<WeatherBloc>()
                              .add(FetchCurrentLocationWeather());
                        },
                        child: Text(
                          'Try Again',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                        )),
                  ],
                ),
              ),
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
