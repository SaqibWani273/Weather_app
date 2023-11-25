import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CityModel {
  final int id;
  String? wikiDataId;
  String? type;
  String? city;
  String? name;
  String? country;
  String? countryCode;
  String? region;
  String? regionCode;
  final double latitude;
  final double longitude;
  int population;
  CityModel({
    required this.id,
    this.wikiDataId,
    this.type,
    this.city,
    this.name,
    this.country,
    this.countryCode,
    this.region,
    this.regionCode,
    required this.latitude,
    required this.longitude,
    required this.population,
  });

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'] as int,
      wikiDataId:
          map['wikiDataId'] != null ? map['wikiDataId'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      countryCode:
          map['countryCode'] != null ? map['countryCode'] as String : null,
      region: map['region'] != null ? map['region'] as String : null,
      regionCode:
          map['regionCode'] != null ? map['regionCode'] as String : null,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      population: map['population'] as int,
    );
  }

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);
}





/*







id:3350606
wikiDataId:"Q24668"
type:"CITY"
city:"Aixirivall"
name:"Aixirivall"
country:"Andorra"
countryCode:"AD"
region:"Sant Julià de Lòria"
regionCode:"06"
latitude:42.46245
longitude:1.50209
population:0
*/