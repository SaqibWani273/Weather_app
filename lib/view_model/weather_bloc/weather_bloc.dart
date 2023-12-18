import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe_app/models/city_model.dart';
import 'package:weathe_app/models/weather_model.dart';
import 'package:weathe_app/repositories/weather_repository.dart';

import '../../constants/custom_exception.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository})
      : super(WeatherInitialState()) {
    on<FetchCurrentLocationWeather>(_fetchCurrentLocationWeather);
    on<FetchSuggestedLocations>(_fetchSuggestedLocations);
    on<FetchLocationWeatherByLatLong>(_fetchLocationWeatherByLatLong);
    //  on<FetchHourlyWeatherEvent>(_fetchHourlyWeather);
  }
  Future<void> _fetchCurrentLocationWeather(
      FetchCurrentLocationWeather event, Emitter<WeatherState> emit) async {
    try {
      emit(LoadingWeatherState());
      final currentWeatherModel = await _fetchFromRepository();
      emit(WeatherLoadedState(
        currentWeatherModel: currentWeatherModel,
      ));
    } on CustomException catch (e) {
      log('custom error while getting weather data from repo: $e ');
      emit(WeatherErrorState(
        error: e,
      ));
    } catch (e) {
      emit(WeatherErrorState(
        error: unknownException,
      ));
    }
  }

  Future<void> _fetchSuggestedLocations(
      FetchSuggestedLocations event, Emitter<WeatherState> emit) async {
    emit(LoadingSuggestedLocations());
    try {
      //  await Future.delayed(Duration(seconds: 12));
      final locations = await weatherRepository.getSuggestedCities(event.query);
      emit(LoadedSuggestedLocations(suggestedLocations: locations));
      if (locations == null) {
        emit(NoSuggestedLocations());
      }
    } on CustomException catch (e) {
      log('unexpected error in fetching suggested locations: $e');
      emit(WeatherErrorState(error: e));
    } catch (e) {
      emit(WeatherErrorState(
        error: unknownException,
      ));
    }
  }

  Future<void> _fetchLocationWeatherByLatLong(
      FetchLocationWeatherByLatLong event, Emitter<WeatherState> emit) async {
    try {
      emit(LoadingWeatherState());
      final currentWeatherModel =
          await _fetchFromRepository(lat: event.lat, longt: event.longt);
      emit(WeatherLoadedState(
        currentWeatherModel: currentWeatherModel,
      ));
      log("Weather model from repo: ${currentWeatherModel.toString()}");
    } on CustomException catch (e) {
      log('custom error while getting weather data from repo: $e');
      emit(WeatherErrorState(
        error: e,
      ));
    } catch (e) {
      emit(WeatherErrorState(
        error: unknownException,
      ));
    }
  }

  Future<WeatherModel> _fetchFromRepository({
    double? lat,
    double? longt,
  }) async {
    try {
      final currentWeatherModel =
          await weatherRepository.getWeatherData(lat: lat, longt: longt);

      return currentWeatherModel;
      // emit(WeatherLoadedState(currentWeatherModel: currentWeatherModel));
    } catch (e) {
      log('custom error while getting weather data from repo: $e');
      //  emit(WeatherErrorState(error: e.message));
      rethrow;
    }
  }

  // Future<void> _fetchHourlyWeather(
  //     FetchHourlyWeatherEvent event, Emitter<WeatherState> emit) async {
  //   try {
  //     emit(LoadingWeatherState());
  //     final hourlyForecastList = await weatherRepository.getHourlyWeather();

  //     emit(LoadedHourlyWeatherState(
  //       hourlyForecastList: hourlyForecastList,
  //     ));
  //   } on CustomException catch (e) {
  //     log('custom error while getting hourly weather data from repo: $e');
  //     emit(WeatherErrorState(
  //       error: e,
  //     ));
  //   } catch (e) {
  //     emit(WeatherErrorState(
  //       error: unknownException,
  //     ));
  //   }
  // }
}
