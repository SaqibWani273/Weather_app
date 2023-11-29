// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe_app/view/widgets/loaded_hourly_weather.dart';

import '../../view_model/weather_bloc/weather_bloc.dart';

class HourlyScreen extends StatefulWidget {
  const HourlyScreen({super.key});

  @override
  State<HourlyScreen> createState() => _HourlyScreenState();
}

class _HourlyScreenState extends State<HourlyScreen> {
  late AxisTitles noTiles;
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(FetchHourlyWeatherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //  height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        color: Colors.blue.shade900.withOpacity(0.3),
        child:
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is LoadingWeatherState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoadedHourlyWeatherState) {
            return LoadedHourlyWeather(
                hourlyWeatherList: state.hourlyWeatherList);
          }
          if (state is WeatherErrorState) {
            return Container(
                color: Colors.white.withBlue(123),
                child: Center(child: Text(state.error!)));
          }
          return Container(
              color: Colors.white.withBlue(123),
              child: const Center(
                  child: Text(
                "Something went wrong",
              )));
        }));
  }
}
