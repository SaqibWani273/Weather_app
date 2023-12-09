import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import '/view_model/hourly_weather_bloc/hourly_weather_bloc.dart';
import 'constants/theme.dart';

import 'view/common_widgets/home_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'constants/firebase_options.dart';
import 'repositories/weather_repository.dart';

import 'view_model/Daily_weather_bloc/daily_weather_bloc.dart';
import 'view_model/weather_bloc/weather_bloc.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(const MyApp());

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => WeatherRepository(),
        child: MultiBlocProvider(
          providers: [
            //for current weather
            BlocProvider<WeatherBloc>(
              create: (context) => WeatherBloc(
                weatherRepository: context.read<WeatherRepository>(),
              )..add(FetchCurrentLocationWeather()),
            ),
            //for hourly weather
            BlocProvider(
              create: (context) => HourlyWeatherBloc(
                weatherRepository: context.read<WeatherRepository>(),
              )..add(FetchHourlyWeatherEvent()),
            ),

            //for daily weather
            BlocProvider(
              create: (context) => DailyWeatherBloc(
                weatherRepository: context.read<WeatherRepository>(),
              )..add(FetchDailyWeatherEvent()),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: CustomTheme().getTheme(),
            home: const HomePage(),
          ),
        ));
  }
}
