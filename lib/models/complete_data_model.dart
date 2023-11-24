// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:weathe_app/models/weather_model.dart';

// class CompleteDataModel {
//   final WeatherModel weatherModel;
//   final String backgroundImage;
//   final String lottieFile;
//   CompleteDataModel({
//     required this.weatherModel,
//     required this.backgroundImage,
//     required this.lottieFile,
//   });

//   CompleteDataModel copyWith({
//     WeatherModel? weatherModel,
//     String? backgroundImage,
//     String? lottieFile,
//   }) {
//     return CompleteDataModel(
//       weatherModel: weatherModel ?? this.weatherModel,
//       backgroundImage: backgroundImage ?? this.backgroundImage,
//       lottieFile: lottieFile ?? this.lottieFile,
//     );
//   }

//   factory CompleteDataModel.fromMap(Map<String, dynamic> map) {
//     return CompleteDataModel(
//       weatherModel:
//           WeatherModel.fromMap(map['weatherModel'] as Map<String, dynamic>),
//       backgroundImage: map['backgroundImage'] as String,
//       lottieFile: map['lottieFile'] as String,
//     );
//   }
// }
