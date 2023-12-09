import 'dart:convert';
import 'dart:developer';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeatherModel {
  final ApiResponseModel apiResponseModel;
  final String imageUrl;
  final String? lottieUrl;
  WeatherModel({
    required this.apiResponseModel,
    required this.imageUrl,
    required this.lottieUrl,
  });
//returns new instance of WeatherModel with updated values from other instance
  WeatherModel copyWith({
    ApiResponseModel? apiResponseModel,
    String? imageUrl,
    String? lottieUrl,
  }) {
    return WeatherModel(
      apiResponseModel: apiResponseModel ?? this.apiResponseModel,
      imageUrl: imageUrl ?? this.imageUrl,
      lottieUrl: lottieUrl ?? this.lottieUrl,
    );
  }
}

class ApiResponseModel {
  Coord coord;
  List<Weather> weather;
//  WeatherList weatherList;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  ApiResponseModel({
    required this.coord,
    //   required this.weatherList,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory ApiResponseModel.fromMap(Map<String, dynamic> map) {
    log("frommap \n \n tostring");
    return ApiResponseModel(
      coord: Coord.fromMap(map['coord'] as Map<String, dynamic>),
      //   weatherList: WeatherList.fromDynamicList(map['weather'] as List<int>),
      weather: List<Weather>.from(
        (map['weather'] as List<dynamic>).map<Weather>(
          (x) => Weather.fromMap(x as Map<String, dynamic>),
        ),
      ),
      base: map['base'] as String,
      main: Main.fromMap(map['main'] as Map<String, dynamic>),
      visibility: map['visibility'] as int,
      wind: Wind.fromMap(map['wind'] as Map<String, dynamic>),
      clouds: Clouds.fromMap(map['clouds'] as Map<String, dynamic>),
      dt: map['dt'] as int,
      sys: Sys.fromMap(map['sys'] as Map<String, dynamic>),
      timezone: map['timezone'] as int,
      id: map['id'] as int,
      name: map['name'] as String,
      cod: map['cod'] as int,
    );
  }

  factory ApiResponseModel.fromJson(String source) {
    log("inside json ");
    return ApiResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>);
  }

  // @override
  // String toString() {
  //   return 'ApiResponseModel(coord: $coord, weatherList: $weatherList, base: $base, main: $main, wind: $wind, clouds: $clouds, dt: $dt, sys: $sys, timezone: $timezone, id: $id, name: $name, cod: $cod)';
  // }
}

class Sys {
  // int type;
  int? id;
  String country;
  int sunrise;
  int sunset;

  Sys({
    // required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromMap(Map<String, dynamic> map) {
    return Sys(
      // // type: map['type'],
      id: map['id'],
      country: map['country'],
      sunrise: map['sunrise'],
      sunset: map['sunset'],
    );
  }

  factory Sys.fromJson(String source) => Sys.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

class Clouds {
  int all;

  Clouds({required this.all});

  factory Clouds.fromMap(Map<String, dynamic> map) {
    return Clouds(
      all: map['all'],
    );
  }
  factory Clouds.fromJson(String source) =>
      Clouds.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Wind {
  double speed;
  int deg;
  double? gust;

  Wind({required this.speed, required this.deg, this.gust});
  factory Wind.fromMap(Map<String, dynamic> map) {
    return Wind(
      deg: map['deg'].round(),
      speed: double.parse(map['speed'].toString()),
      gust:
          map.containsKey("gust") ? double.parse(map['gust'].toString()) : null,
    );
  }
  factory Wind.fromJson(String source) =>
      Wind.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });
  factory Main.fromMap(Map<String, dynamic> map) {
    return Main(
      temp: double.parse(map['temp'].toString()),
      feelsLike:
          double.parse(map['feels_like'].toString()), // map['feels_like'],
      tempMin: double.parse(map['temp_min'].toString()), // map['temp_min'],
      tempMax: double.parse(map['temp_max'].toString()), // map['temp_max'],
      pressure: map['pressure'] as int,
      humidity: map['humidity'] as int,
    );
  }
  factory Main.fromJson(String source) =>
      Main.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      id: map['id'] as int,
      main: map['main'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
    );
  }

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Coord {
  final double lon;
  final double lat;
  Coord({
    required this.lon,
    required this.lat,
  });

  Coord copyWith({
    double? lon,
    double? lat,
  }) {
    return Coord(
      lon: lon ?? this.lon,
      lat: lat ?? this.lat,
    );
  }

  factory Coord.fromMap(Map<String, dynamic> map) {
    return Coord(
      lon: double.parse(map['lon'].toString()),
      lat: double.parse(map['lat'].toString()),
    );
  }

  factory Coord.fromJson(String source) =>
      Coord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Coord(lon: $lon, lat: $lat)';
}

class WeatherList {
  final List<Weather> weatherList;
  WeatherList({
    required this.weatherList,
  });
  // factory WeatherList.fromDynamicList(List<dynamic> list) {
  //   return WeatherList(
  //       weatherList: list.map<Weather>((e) => Weather.fromMap(e)));
  // }
}
