// import 'dart:convert';
// import 'dart:math';
// import 'dart:developer' as dev;

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class WeatherModel {
//   final String cityName;
//   final String country;
//   final double temp;
//   final double feelsLike;
//   final double minTemp;
//   final double maxTemp;
//   final int humidity;
//   final int pressure;
//   final double windSpeed;
//   final String description;
//   final String sunrise;
//   final String sunset;
//   final WeatherStatus weatherStatus;
//   WeatherModel({
//     required this.cityName,
//     required this.country,
//     required this.temp,
//     required this.feelsLike,
//     required this.minTemp,
//     required this.maxTemp,
//     required this.humidity,
//     required this.pressure,
//     required this.windSpeed,
//     required this.description,
//     required this.sunrise,
//     required this.sunset,
//     required this.weatherStatus,
//   });

//   // Map<String, dynamic> toMap() {
//   //   return <String, dynamic>{
//   //     'cityName': cityName,
//   //     'country': country,
//   //     'temp': temp,
//   //     'feelsLike': feelsLike,
//   //     'minTemp': minTemp,
//   //     'maxTemp': maxTemp,
//   //     'humidity': humidity,
//   //     'pressure': pressure,
//   //     'windSpeed': windSpeed,
//   //     'description': description,
//   //     'sunrise': sunrise,
//   //     'sunset': sunset,
//   //   };
//   // }

//   factory WeatherModel.fromMap(Map<String, dynamic> map) {
//     // map.forEach((key, value) {
//     //   if (key == "main") {
//     //     dev.log("\n\n\n...$key : $value , type = ${value.runtimeType}");
//     //     Map myMap = map["main"];
//     //     myMap.forEach((key, value) {
//     //       dev.log("$key : ${value.runtimeType}");
//     //     });
//     //   }
//     // });
//     dev.log("...item= ${map['name']}");
//     dev.log("item= ${map['sys']['country']}");

//     dev.log("item= ${map['main']['temp']}");

//     dev.log("item= ${map['main']['feelsLike']}");

//     dev.log("item= ${map['main']['minTemp']}");

//     dev.log("item= ${map['main']['maxTemp']}");

//     dev.log("item= ${map['main']['humidity']}");

//     dev.log("item= ${map['main']['pressure']}");

//     dev.log("item= ${map['windSpeed']}");

//     dev.log("item= ${map['weather']['description']}");

//     dev.log("item= ${map['sys']['sunrise']}");

//     dev.log("item= ${map['sys']['sunset']}");
//     return WeatherModel(
//         cityName: map['name'] as String,
//         country: map['sys']['country'] as String,
//         temp: map['main']['temp'] as double,
//         feelsLike: map['main']['feels_Like'] as double,
//         minTemp: map['main']['minTemp'] as double,
//         maxTemp: map['main']['maxTemp'] as double,
//         humidity: map['main']['humidity'] as int,
//         pressure: map['main']['pressure'] as int,
//         windSpeed: map['windSpeed'] as double,
//         description: map['weather']['description'] as String,
//         sunrise: map['sys']['sunrise'] as String,
//         sunset: map['sys']['sunset'] as String,
//         weatherStatus: WeatherStatus.values.firstWhere(
//           (enumValue) => enumValue.toString() == '${map['weather']['main']}',
//         ));
//   }

//   factory WeatherModel.fromJson(String source) =>
//       WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// enum WeatherStatus {
//   clearSky,
//   clouds,
//   rain,
//   thunderstorm,
//   snow,
//   mist,
//   fog,
//   wind,
//   cold,
//   hot,
//   lowHumidity,
//   partlyCloudy,
// }
// /*
// {"coord":{"lon":74.9794,"lat":33.9578},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"base":"stations","main":{"temp":16.04,"feels_like":14.22,"temp_min":16.04,"temp_max":16.04,"pressure":1012,"humidity":20,"sea_level":1012,"grnd_level":838},"visibility":10000,"wind":{"speed":0.77,"deg":278,"gust":1.12},"clouds":{"all":0},"dt":1700735411,"sys":{"country":"IN","sunrise":1700703575,"sunset":1700740404},"timezone":19800,"id":1278103,"name":"Awantipur","cod":200}



// */


// /*


// {
//   "coord": {
//     "lon": -122.4194,
//     "lat": 37.7749
//   },
//   "weather": [
//     {
//       "id": 800,
//       "main": "Clear",
//       "description": "clear sky",
//       "icon": "01d"
//     }
//   ],
//   "base": "stations",
//   "main": {
//     "temp": 21.5,
//     "feels_like": 20.1,
//     "temp_min": 20.5,
//     "temp_max": 22.5,
//     "pressure": 1016,
//     "humidity": 50
//   },
//   "visibility": 10000,
//   "wind": {
//     "speed": 5.1,
//     "deg": 180
//   },
//   "clouds": {
//     "all": 0
//   },
//   "dt": 1637277755,
//   "sys": {
//     "type": 1,
//     "id": 5122,
//     "country": "US",
//     "sunrise": 1637240964,
//     "sunset": 1637280819
//   },
//   "timezone": -28800,
//   "id": 5392171,
//   "name": "San Francisco",
//   "cod": 200
// }






// */
