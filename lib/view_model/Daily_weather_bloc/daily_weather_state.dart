part of 'daily_weather_bloc.dart';

@immutable
sealed class DailyWeatherState {}

final class DailyWeatherInitial extends DailyWeatherState {}

final class LoadingDailyWeatherState extends DailyWeatherState {}

final class LoadedDailyWeatherState extends DailyWeatherState {
  final List<ForecastWeatherModel> dailyForecastList;
  LoadedDailyWeatherState({required this.dailyForecastList});
}

final class DailyWeatherErrorState extends DailyWeatherState {
  final CustomException error;
  DailyWeatherErrorState({required this.error});
}
