import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe_app/repositories/weather_repository.dart';
import 'package:weathe_app/view_model/weather_bloc/weather_bloc.dart';

class SearchWeather extends StatelessWidget {
  SearchWeather({super.key});
  final List<String> suggestions = [];
  @override
  Widget build(BuildContext context) {
    showSnackbar(context);

    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      body: Container(
        color: Colors.blue.shade400,
        margin: EdgeInsets.only(top: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              onChanged: (value) {
                context
                    .read<WeatherBloc>()
                    .add(FetchSuggestedLocations(query: value));
              },
              decoration: InputDecoration(
                hintText: 'enter city name here',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.9),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
              ),
              style: const TextStyle(height: 0.9),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              onTap: () {
                context.read<WeatherBloc>().add(FetchCurrentLocationWeather());
                Navigator.pop(context);
              },

              leading: Icon(Icons.location_on_outlined),
              title: Text("Select current Location"),
              // subtitle: Text("Srinagar,India"),
            ),
          ),
          Divider(
            height: 5,
          ),
          Expanded(
            child: Container(
                color: Colors.white,
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is LoadingSuggestedLocations) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is LoadedSuggestedLocations) {
                      return ListView.builder(
                        itemCount: state.suggestedLocations?.length,
                        itemBuilder: (context, index) {
                          final location = state.suggestedLocations![index];

                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  context.read<WeatherBloc>().add(
                                      FetchLocationWeatherByLatLong(
                                          lat: location.latitude,
                                          longt: location.longitude));
                                  Navigator.pop(context);
                                },
                                tileColor: Colors.grey.withOpacity(0.3),
                                leading: Icon(Icons.location_on_outlined),
                                title: Text(
                                    "${location.name},${location.region ?? ""}"),
                                subtitle: Text(
                                  location.country ?? "",
                                ),
                              ),
                              Divider(
                                height: 2,
                                color: Colors.blue,
                              )
                            ],
                          );
                        },
                      );
                    }

                    return Container(
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //     "Discover real-time weather, current date, and time for any location worldwide.",
                          //     style:
                          //         TextStyle(color: Colors.black, fontSize: 20)),
                          // Spacer(),
                          Image.asset(
                              "assets/images/search_weather_waiting.jpg"),
                          Text(
                            "Suggested cities will appear here",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      )),
                    );
                  },
                )),
          )
        ]),
      ),
    );
  }
}

void showSnackbar(BuildContext context) {
  bool showedSnack = context.read<WeatherRepository>().showedSnackBar;
  if (!showedSnack) {
    Future.delayed(Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Discover real-time weather, current date and time for any location worldwide.",
            style: TextStyle(fontSize: 15),
          ),
          showCloseIcon: true,
        ),
      );
    });

    context.read<WeatherRepository>().showedSnackBar = true;
  }
}
