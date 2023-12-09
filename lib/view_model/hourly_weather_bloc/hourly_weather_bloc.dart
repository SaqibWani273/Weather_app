import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/custom_exception.dart';
import '../../models/hourly_weather_model.dart';
import '../../repositories/weather_repository.dart';

part 'hourly_weather_event.dart';
part 'hourly_weather_state.dart';

class HourlyWeatherBloc extends Bloc<HourlyWeatherEvent, HourlyWeatherState> {
  final WeatherRepository weatherRepository;
  HourlyWeatherBloc({required this.weatherRepository})
      : super(HourlyWeatherInitial()) {
    on<FetchHourlyWeatherEvent>(_fetchHourlyWeather);
  }
  Future<void> _fetchHourlyWeather(
      FetchHourlyWeatherEvent event, Emitter<HourlyWeatherState> emit) async {
    try {
      emit(LoadingHourlyWeatherState());
      //pass a named parameter isHourly adn set it to true here
      final hourlyForecastList =
          await weatherRepository.getForecastWeather(isHourly: true);

      emit(LoadedHourlyWeatherState(
        hourlyForecastList: hourlyForecastList,
      ));
    } on CustomException catch (e) {
      log('custom error while getting hourly weather data from repo: $e');
      emit(HourlyWeatherErrorState(
        error: e,
      ));
    } catch (e) {
      emit(HourlyWeatherErrorState(
        error: unknownException,
      ));
    }
  }
}
