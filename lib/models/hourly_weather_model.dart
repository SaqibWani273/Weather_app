// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:weathe_app/models/weather_model1.dart';

class HourlyWeatherModel {
  final Main main;
  final List<Weather> weather;
  final Clouds clouds;
  final int dt;
  final Wind wind;
  final int visibility;
  final String dt_txt;
  final String hour;
  HourlyWeatherModel({
    required this.main,
    required this.weather,
    required this.clouds,
    required this.dt,
    required this.wind,
    required this.visibility,
    required this.dt_txt,
    required this.hour,
  });

  factory HourlyWeatherModel.fromMap(
      Map<String, dynamic> map, final String hour) {
    return HourlyWeatherModel(
      main: Main.fromMap(map['main'] as Map<String, dynamic>),
      weather: List<Weather>.from(
        (map['weather'] as List<dynamic>).map<Weather>(
          (x) => Weather.fromMap(x as Map<String, dynamic>),
        ),
      ),
      clouds: Clouds.fromMap(map['clouds'] as Map<String, dynamic>),
      dt: map['dt'] as int,
      wind: Wind.fromMap(map['wind'] as Map<String, dynamic>),
      visibility: map['visibility'] as int,
      dt_txt: map['dt_txt'] as String,
      hour: hour,
    );
  }

  // factory HourlyWeatherModel.fromJson(String source) =>
  //     HourlyWeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);
}






/*

{
            "dt": 1701075600,
            "main": {
                "temp": 274.37,
                "feels_like": 274.37,
                "temp_min": 274.37,
                "temp_max": 277.25,
                "pressure": 1013,
                "sea_level": 1013,
                "grnd_level": 925,
                "humidity": 74,
                "temp_kf": -2.88
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 100
            },
            "wind": {
                "speed": 0.6,
                "deg": 179,
                "gust": 2.12
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-11-27 09:00:00"
        },
*/