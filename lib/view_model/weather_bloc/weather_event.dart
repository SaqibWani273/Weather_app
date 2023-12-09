part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class FetchCurrentLocationWeather extends WeatherEvent {}

class FetchDefaultLocationWeather extends WeatherEvent {}

class FetchSuggestedLocations extends WeatherEvent {
  final String query;
  FetchSuggestedLocations({required this.query});
}

class FetchLocationWeatherByLatLong extends WeatherEvent {
  final double lat;
  final double longt;
  FetchLocationWeatherByLatLong({required this.lat, required this.longt});
}

// class FetchHourlyWeatherEvent extends WeatherEvent {}
