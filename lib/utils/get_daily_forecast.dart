/*
As the openweathermapapi doesnot provide exclusively the daily forecast data
we are using the hourly forecast data to get the daily forecast data by
taking the average of the hourly forecast data for the day(i.e. 24 hrs)

*/

import 'package:weathe_app/utils/date_formatter.dart';

import '../models/hourly_weather_model.dart' as hwm;
import '../models/weather_model1.dart';

List<hwm.ForecastWeatherModel> getDailyForecast(
    List<hwm.ForecastWeatherModel> completeWeatherList,
    DateFormatter dateFormatter) {
  List<hwm.ForecastWeatherModel> dailyForecast = [];
  final DateTime currentDate = dateFormatter.getCurrentDateTimeofLocation(
      dtInMillis: completeWeatherList[0].dt);
  //   Main main;
  double temperature = 0;
  double feelsLike = 0;
  double tempMin = 0;
  double tempMax = 0;
  int pressure = 0;
  int humidity = 0;
  //  List<Weather> weather;
  int id = 123;
  String main = "dummy main";
  String description = "dummy description";
  String icon = "xyz";
  //  Clouds clouds;
  int all = 0;
  //  Wind wind;
  double speed = 0;
  int deg = 0;
  double gust = 0;

  //...easier ones
  int visibility = 0;
  double probOfPercpipitation = 0.0;

  late DateTime temp;
  for (int i = 0, j = 0; i < completeWeatherList.length; i++, j++) {
    temp = dateFormatter.getCurrentDateTimeofLocation(
        dtInMillis: completeWeatherList[i].dt);
    if (currentDate.day == temp.day) {
      //=> it is the same day but i want to start from tomorrow
      //as we cannot calculate the avg from the middle of the day
      j = 0; // to calculate 24 hrs from tomorrow
      continue;
    }

    if (j % 8 == 0 && j != 0) {
//=> 24 hrs completed, its 3-hourly forecast (3*8=24)
      temp = dateFormatter.getCurrentDateTimeofLocation(
          dtInMillis: completeWeatherList[j - 1].dt);
      dailyForecast.add(
        hwm.ForecastWeatherModel(
          main: Main(
            temp: temperature / 8,
            feelsLike: feelsLike / 8,
            tempMin: tempMin,
            tempMax: tempMax,
            pressure: (pressure / 8).round(),
            humidity: (humidity / 8).round(),
          ),
          weather: [
            Weather(
              id: id, //not needed
              main: main, //not needed
              description: description, //not needed
              icon: icon, //not needed
            )
          ],
          clouds: Clouds(all: (all / 8).round()),
          dt: completeWeatherList[j - 1].dt,
          wind: Wind(speed: speed / 8, deg: (deg / 8).round(), gust: gust / 8),
          sys: hwm.Sys(partOfDay: "null"), //not needed//not needed
          visibility: (visibility / 8).round(),
          probOfPercpipitation: probOfPercpipitation / 8,
          dt_txt: completeWeatherList[j - 1].dt_txt, //not needed
          day: dateFormatter.getFormattedDay(temp),
        ),
      );
//resetting the values for next day
      visibility = 0;
      probOfPercpipitation = 0.0;
      temperature = 0;
      feelsLike = 0;
      tempMin = 100;
      tempMax = -100;
      pressure = 0;
      humidity = 0;
      all = 0;
      speed = 0;
      deg = 0;
      gust = 0;
      tempMax = -100;
      tempMin = 100;
    }
    //adding the values to get the avg
    temperature += completeWeatherList[j].main.temp;
    feelsLike += completeWeatherList[j].main.feelsLike;
    tempMin = completeWeatherList[j].main.tempMin < tempMin
        ? completeWeatherList[j].main.tempMin
        : tempMin; //to get the min
    tempMax = completeWeatherList[j].main.tempMax > tempMax
        ? completeWeatherList[j].main.tempMax
        : tempMax; //to get the max
    pressure += completeWeatherList[j].main.pressure;
    humidity += completeWeatherList[j].main.humidity;
    all += completeWeatherList[j].clouds.all;
    speed += completeWeatherList[j].wind.speed;
    deg += completeWeatherList[j].wind.deg;
    gust += completeWeatherList[j].wind.gust ?? 0;
    visibility += completeWeatherList[j].visibility;
    probOfPercpipitation += completeWeatherList[j].probOfPercpipitation;
  }
  return dailyForecast;
}
