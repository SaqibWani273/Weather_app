import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weathe_app/constants/theme.dart';
import 'package:weathe_app/view/home_page.dart';
import 'package:weathe_app/view/today_screen.dart';

import 'firebase_options.dart';
import 'repositories/weather_repository.dart';

import 'view_model/weather_bloc/weather_bloc.dart';

Future<void> main() async {
  //to do:
  //till the necessary data for today screen is fetched
  //show splash screen
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => WeatherRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<WeatherBloc>(
              create: (context) => WeatherBloc(
                  weatherRepository: context.read<WeatherRepository>())
                ..add(FetchCurrentLocationWeather()),
            ),
            // BlocProvider<CitiesBloc>(
            // create: (context) => CitiesBloc(
            // weatherRepository: context.read<WeatherRepository>()))
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: CustomTheme().getTheme(),
            home: const HomePage(),
          ),
        ));
  }
}
