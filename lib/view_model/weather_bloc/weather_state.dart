part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class LoadingWeatherState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weatherModel;
  WeatherLoadedState({required this.weatherModel});
}

class WeatherErrorState extends WeatherState {
  String? error = "Error occurred!";
  WeatherErrorState({this.error});
}

class LoadedSuggestedLocations extends WeatherState {
  final List<CityModel>? suggestedLocations;
  LoadedSuggestedLocations({required this.suggestedLocations});
}

class LoadingSuggestedLocations extends WeatherState {}

class NoSuggestedLocations extends WeatherState {}

class LoadedHourlyWeatherState extends WeatherState {
  final List<HourlyWeatherModel> hourlyWeatherList;
  LoadedHourlyWeatherState({required this.hourlyWeatherList});
}
