import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe_app/models/hourly_weather_model.dart';

import '../../constants/custom_exception.dart';
import '../../repositories/weather_repository.dart';

part 'daily_weather_event.dart';
part 'daily_weather_state.dart';

class DailyWeatherBloc extends Bloc<DailyWeatherEvent, DailyWeatherState> {
  final WeatherRepository weatherRepository;
  DailyWeatherBloc({required this.weatherRepository})
      : super(DailyWeatherInitial()) {
    on<FetchDailyWeatherEvent>(_fetchDailyWeather);
  }
  Future<void> _fetchDailyWeather(
      FetchDailyWeatherEvent event, Emitter<DailyWeatherState> emit) async {
    emit(LoadingDailyWeatherState());
    try {
      final dailyForecastList =
          await weatherRepository.getForecastWeather(isHourly: false);

      emit(LoadedDailyWeatherState(
        dailyForecastList: dailyForecastList,
      ));
    } on CustomException catch (e) {
      log('custom error while getting daily weather data from repo: $e');
      emit(DailyWeatherErrorState(
        error: e,
      ));
    } catch (e) {
      emit(DailyWeatherErrorState(
        error: unknownException,
      ));
    }
  }
}
