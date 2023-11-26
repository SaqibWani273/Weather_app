import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe_app/models/city_model.dart';
import 'package:weathe_app/models/weather_model1.dart';
import 'package:weathe_app/repositories/weather_repository.dart';

import '../../constants/custom_exception.dart';
import '../../models/complete_data_model.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required this.weatherRepository})
      : super(WeatherInitialState()) {
    on<FetchCurrentLocationWeather>(_fetchCurrentLocationWeather);
    on<FetchSuggestedLocations>(_fetchSuggestedLocations);
    on<FetchLocationWeatherByLatLong>(_fetchLocationWeatherByLatLong);
  }
  final WeatherRepository weatherRepository;
  Future<void> _fetchCurrentLocationWeather(
      FetchCurrentLocationWeather event, Emitter<WeatherState> emit) async {
    try {
      final weatherModel = await _fetchFromRepository();
      emit(WeatherLoadedState(
        weatherModel: weatherModel,
      ));
    } on CustomException catch (e) {
      log('custom error while getting weather data from repo: $e');
      emit(WeatherErrorState(
        error: e.message,
      ));
    } catch (e) {
      emit(WeatherErrorState(
        error: "Unexpected Error Occurred\n Please Try Again!",
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
      log('unexpected error in fetching suggested locations: ${e}');
      emit(WeatherErrorState(
          error: "Unexpected Error Occurred\n Please Try Again!"));
    }
  }

  Future<void> _fetchLocationWeatherByLatLong(
      FetchLocationWeatherByLatLong event, Emitter<WeatherState> emit) async {
    try {
      emit(LoadingWeatherState());
      final weatherModel =
          await _fetchFromRepository(lat: event.lat, longt: event.longt);
      emit(WeatherLoadedState(
        weatherModel: weatherModel,
      ));
      log("Weather model from repo: ${weatherModel.toString()}");
    } on CustomException catch (e) {
      log('custom error while getting weather data from repo: $e');
      emit(WeatherErrorState(
        error: e.message,
      ));
    } catch (e) {
      emit(WeatherErrorState(
        error: "Unexpected Error Occurred\n Please Try Again!",
      ));
    }
  }

  Future<WeatherModel> _fetchFromRepository({
    double? lat,
    double? longt,
  }) async {
    try {
      final weatherModel =
          await weatherRepository.getWeatherData(lat: lat, longt: longt);
      return weatherModel;
      // emit(WeatherLoadedState(weatherModel: weatherModel));
    } catch (e) {
      log('custom error while getting weather data from repo: $e');
      //  emit(WeatherErrorState(error: e.message));
      rethrow;
    }
  }
}