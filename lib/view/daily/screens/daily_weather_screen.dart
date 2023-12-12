import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view_model/Daily_weather_bloc/daily_weather_bloc.dart';
import '../../common_widgets/error_screen.dart';
import '../../common_widgets/loading_weather.dart';
import '../widgets/loaded_daily_weather.dart';

class DailyWeatherScreen extends StatefulWidget {
  const DailyWeatherScreen({super.key});

  @override
  State<DailyWeatherScreen> createState() => _DailyWeatherScreenState();
}

class _DailyWeatherScreenState extends State<DailyWeatherScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DailyWeatherBloc>(context).add(FetchDailyWeatherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<DailyWeatherBloc, DailyWeatherState>(
            builder: (context, state) {
          if (state is LoadedDailyWeatherState) {
            // return LoadedDailyWeather(
            //     dailyForecastList: state.dailyForecastList);
            return LoadedDailyWeather(
                dailyWeatherList: state.dailyForecastList);
          }
          if (state is DailyWeatherErrorState) {
            return ErrorScreen(
              customException: state.error,
            );
          }
          return const LoadingWeather();
        })

        //      Center(
        //   child: Text('Daily'),
        // ),
        );
  }
}
