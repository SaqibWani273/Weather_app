// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/loaded_hourly_weather.dart';
import '../../view_model/hourly_weather_bloc/hourly_weather_bloc.dart';

import '../common_widgets/error_screen.dart';
import '../common_widgets/loading_weather.dart';

class HourlyScreen extends StatefulWidget {
  const HourlyScreen({super.key});

  @override
  State<HourlyScreen> createState() => _HourlyScreenState();
}

class _HourlyScreenState extends State<HourlyScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HourlyWeatherBloc>(context).add(FetchHourlyWeatherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HourlyWeatherBloc, HourlyWeatherState>(
        builder: (context, state) {
      if (state is LoadingHourlyWeatherState) {
        return const LoadingWeather();
      }
      if (state is LoadedHourlyWeatherState) {
        return LoadedHourlyWeather(
            hourlyForecastList: state.hourlyForecastList);
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
