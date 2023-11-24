part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class FetchCurrentLocationWeather extends WeatherEvent {}

class FetchDefaultLocationWeather extends WeatherEvent {}
