import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe_app/constants/custom_exception.dart';
import 'package:weathe_app/view/common_widgets/error_screen.dart';
import 'package:weathe_app/view/common_widgets/loading_weather.dart';

import '../../view_model/weather_bloc/weather_bloc.dart';
import 'widgets/loaded_today_widget.dart';

class TodayScreen extends StatelessWidget {
  final Function(bool) changeLoading;
  const TodayScreen({super.key, required this.changeLoading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitialState || state is LoadingWeatherState) {
            changeLoading(true);
            return const LoadingWeather();
          }

          if (state is WeatherLoadedState) {
            changeLoading(false);
            return LoadedTodayWidget(
              state: state,
            );
          }

          if (state is WeatherErrorState) {
            return ErrorScreen(
              customException: state.error,
            );
          } else {
            return ErrorScreen(
              customException: unknownException,
            );
          }
        },
      ),
    );
  }
}
