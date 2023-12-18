import 'package:weathe_app/models/weather_model.dart';

//using this model for both hourly and daily weather forecast
class ForecastWeatherModel {
  final Main main;
  final List<Weather> weather;
  final Clouds clouds;
  final int dt;
  final Wind wind;
  final int visibility;
  final String dt_txt;
  final String? hour; //only for hourly
  final double probOfPercpipitation;
  final Sys sys;
  final String? day; //only for daily
  ForecastWeatherModel({
    required this.main,
    required this.weather,
    required this.clouds,
    required this.dt,
    required this.wind,
    required this.visibility,
    required this.dt_txt,
    this.hour,
    required this.probOfPercpipitation,
    required this.sys,
    this.day,
  });

  factory ForecastWeatherModel.fromMap(Map<String, dynamic> map,
      {String? hour, String? day}) {
    return ForecastWeatherModel(
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
      probOfPercpipitation: double.parse(
        map['pop'].toString(),
      ),
      sys: Sys.fromMap(map['sys'] as Map<String, dynamic>),
      hour: hour,
      day: day,
    );
  }

  // factory ForecastWeatherModel.fromJson(String source) =>
  //     ForecastWeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Sys {
  final String partOfDay;
  Sys({
    required this.partOfDay,
  });

  factory Sys.fromMap(Map<String, dynamic> map) {
    return Sys(
      partOfDay: map['pod'] as String,
    );
  }
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
