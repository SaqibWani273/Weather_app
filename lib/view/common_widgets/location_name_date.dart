import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/weather_model.dart';
import '../../repositories/weather_repository.dart';

class LocationNameDate extends StatelessWidget {
  const LocationNameDate({
    super.key,
    required this.apiResponseModel,
  });

  final ApiResponseModel apiResponseModel;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = context.read<WeatherRepository>().dateFormatter;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 3,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "${apiResponseModel.name}, ${apiResponseModel.sys.country}",
            ),
            const SizedBox(
              height: 10,
            ),
            FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.contain,
              child: Text(
                dateFormatter.formattedDateTime,
                textScaler: const TextScaler.linear(1.8),
              ),
            ),
          ]),
        ),
        const Spacer(),
      ],
    );
  }
}
