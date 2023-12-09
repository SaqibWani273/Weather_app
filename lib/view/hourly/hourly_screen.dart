// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view/hourly/widgets/loaded_hourly_weather.dart';
import '../../view_model/hourly_weather_bloc/hourly_weather_bloc.dart';

import '../common_widgets/error_screen.dart';
import '../common_widgets/loading_weather.dart';

class HourlyScreen extends StatelessWidget {
  const HourlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HourlyWeatherBloc, HourlyWeatherState>(
        builder: (context, state) {
      if (state is LoadingHourlyWeatherState) {
        return const LoadingWeather();
      }
      if (state is LoadedHourlyWeatherState) {
        return LoadedHourlyWeather(hourlyWeatherList: state.hourlyWeatherList);
      }
      if (state is HourlyWeatherErrorState) {
        return ErrorScreen(
          customException: state.error,
        );
      }
      return const LoadingWeather();
    });
  }
}
