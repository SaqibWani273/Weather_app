import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
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
  }
  final WeatherRepository weatherRepository;
  void _fetchCurrentLocationWeather(
      FetchCurrentLocationWeather event, Emitter<WeatherState> emit) async {
    try {
      final weatherModel = await weatherRepository.getCompleteData();
      emit(WeatherLoadedState(weatherModel: weatherModel));
    } on CustomException catch (e) {
      log('custom error : $e');
      emit(WeatherErrorState(error: e.message));
    } catch (e) {
      log('unexpected error : $e');
      emit(WeatherErrorState(
          error: "Unexpected Error Occurred\n Please Try Again!"));
    }
  }
}
