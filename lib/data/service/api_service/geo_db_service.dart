import 'dart:convert';
import 'dart:developer';

import 'package:weathe_app/models/city_model.dart';
import 'package:http/http.dart' as http;
import '../../../constants/api_keys.dart';

class GeoDBApi {
  Future<List<CityModel>?> fetchSuggestedCities(String query) async {
    List<CityModel>? cities;
    final url =
        'https://wft-geo-db.p.rapidapi.com/v1/geo/cities?namePrefix=$query';
    final response = await http.get(Uri.parse(url), headers: {
      'X-RapidAPI-Key': rapidApiKey,
      'X-RapidAPI-Host': rapidApiHostKey,
    });
    if (response.statusCode == 200) {
      log("response = ${response.body}");
      //
      final decodedResponse = jsonDecode(response.body);
      cities = [];
      for (var cityData in decodedResponse['data']) {
        log("cityData = ${cityData['name']}");
        cities.add(CityModel.fromMap(cityData));
      }

      //
      // final temp = CityModel.fromJson(response.body);
    } else {
      log("response = nosucces , code=${response.statusCode}");
    }
    return cities;
  }
}
