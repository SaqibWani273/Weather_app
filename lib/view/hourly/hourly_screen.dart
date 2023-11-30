// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe_app/view/hourly/widgets/loaded_hourly_weather.dart';

import '../../view_model/weather_bloc/weather_bloc.dart';
import '../widgets/error_screen.dart';
import '../widgets/loading_weather.dart';

class HourlyScreen extends StatefulWidget {
  const HourlyScreen({super.key});

  @override
  State<HourlyScreen> createState() => _HourlyScreenState();
}

class _HourlyScreenState extends State<HourlyScreen> {
  // late AxisTitles noTiles;
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(FetchHourlyWeatherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is LoadingWeatherState) {
        return const LoadingWeather();
      }
      if (state is LoadedHourlyWeatherState) {
        return LoadedHourlyWeather(hourlyWeatherList: state.hourlyWeatherList);
      }
      if (state is WeatherErrorState) {
        return ErrorScreen(
          customException: state.error,
        );
      }
      return const LoadingWeather();
    });
  }
}
