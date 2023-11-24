import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'repositories/weather_repository.dart';
import 'view/home_page.dart';
import 'view/weather_bloc/weather_bloc.dart';

Future<void> main() async {
  //to do:
  //till the necessary data for today screen is fetched
  //show splash screen
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => WeatherRepository(),
        child: BlocProvider<WeatherBloc>(
          create: (context) =>
              WeatherBloc(weatherRepository: context.read<WeatherRepository>())
                ..add(FetchCurrentLocationWeather()),
          child: const HomePage(),
        ),
      ),
    );
  }
}
