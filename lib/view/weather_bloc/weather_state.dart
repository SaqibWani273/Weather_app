part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weatherModel;
  WeatherLoadedState({required this.weatherModel});
}

class WeatherErrorState extends WeatherState {
  String? error = "Error occurred!";
  WeatherErrorState({this.error});
}
