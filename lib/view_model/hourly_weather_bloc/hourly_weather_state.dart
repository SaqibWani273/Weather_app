part of 'hourly_weather_bloc.dart';

abstract class HourlyWeatherState {}

final class HourlyWeatherInitial extends HourlyWeatherState {}

final class LoadingHourlyWeatherState extends HourlyWeatherState {}

final class LoadedHourlyWeatherState extends HourlyWeatherState {
  final List<HourlyWeatherModel> hourlyWeatherList;
  LoadedHourlyWeatherState({required this.hourlyWeatherList});
}

final class HourlyWeatherErrorState extends HourlyWeatherState {
  final CustomException error;
  HourlyWeatherErrorState({required this.error});
}
