part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class LoadingWeatherState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel currentWeatherModel;
  WeatherLoadedState({required this.currentWeatherModel});
}

class WeatherErrorState extends WeatherState {
  final CustomException error;
  WeatherErrorState({required this.error});
}

class LoadedSuggestedLocations extends WeatherState {
  final List<CityModel>? suggestedLocations;
  LoadedSuggestedLocations({required this.suggestedLocations});
}

class LoadingSuggestedLocations extends WeatherState {}

class NoSuggestedLocations extends WeatherState {}

// class LoadedHourlyWeatherState extends WeatherState {
//   final List<ForecastWeatherModel> hourlyForecastList;
//   LoadedHourlyWeatherState({required this.hourlyForecastList});
// }
