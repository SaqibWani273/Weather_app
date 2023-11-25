// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:weathe_app/data/service/api_service.dart';
// import 'package:weathe_app/view_model/weather_bloc/weather_bloc.dart';

// class SearchWeather extends StatefulWidget {
//   const SearchWeather({super.key});

//   @override
//   State<SearchWeather> createState() => _SearchWeatherState();
// }

// class _SearchWeatherState extends State<SearchWeather> {
//   // final double textFieldContainerHeight = 50;
//   // var showTextField = false;
//   // var showSuggesstions = false;
//   // List<String?> previousSuggestions = [];
//   // List<String?> suggestions = [];

//   // void changeShowSuggesstions(bool val) {
//   //   setState(() {
//   //     showSuggesstions = val;
//   //   });
//   // }

//   // void changeShowTextField(bool val) {
//   //   setState(() {
//   //     showTextField = val;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       backgroundColor: Colors.blue.shade400,
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Stack(children: [
//           if (showSuggesstions)
//             Container(
//               //   alignment: Alignment.center,
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               margin:
//                   EdgeInsets.only(left: 30, top: textFieldContainerHeight + 5),
//               color: Colors.grey.withOpacity(0.9),
//               child: ListView.builder(
//                 itemCount: suggestions.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     child: ListTile(
//                         tileColor: Colors.white,
//                         title: Text(
//                           suggestions[index]!,
//                         )),
//                   );
//                 },
//               ),
//             ),
//           Positioned(
//               top: 0,
//               // right: 0,
//               child: Container(
//                 margin: EdgeInsets.only(bottom: 50),
//                 width: MediaQuery.of(context).size.width,
//                 height: textFieldContainerHeight,
//                 padding: EdgeInsets.symmetric(horizontal: 50),
//                 child: TextField(
//                     textAlign: TextAlign.center,
//                     onTap: () {
//                       changeShowSuggesstions(true);
//                     },
//                     onChanged: (value) async {
//                       // context
//                       //     .read<WeatherBloc>()
//                       //     .add(FetchSuggestedLocations(query: value));
//                       // if (suggestions.isNotEmpty &&
//                       //     suggestions != previousSuggestions) {
//                       //   previousSuggestions = suggestions;
//                       //   //    toggleShowSuggesstions();
//                       //   setState(() {});
//                       // }
//                     },
//                     decoration: InputDecoration(
//                       hintText:
//                           'search a city', // showTextField ? 'search' : "",
//                       suffixIcon: IconButton(
//                         onPressed: () {
//                           changeShowTextField(true);
//                           changeShowSuggesstions(true);
//                         },
//                         icon: const Icon(
//                           Icons.search,
//                           color: Colors.white,
//                         ),
//                       ),
//                       //  filled: true,
//                       // fillColor: showTextField
//                       //     ? Colors.white.withOpacity(0.7)
//                       //     : Colors.transparent,
//                       border: UnderlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(color: Colors.blue),
//                       ),
//                     )),
//               )),
//         ]),
//       ),
//     );
//   }
// }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe_app/view_model/cities_bloc/cities_bloc.dart';
import 'package:weathe_app/view_model/weather_bloc/weather_bloc.dart';

class SearchWeather extends StatelessWidget {
  SearchWeather({super.key});
  final List<String> suggestions = [];
  @override
  Widget build(BuildContext context) {
    log("search weather build called");
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
                // context.read<CitiesBloc>().add(GetCitiesEvent(query: value));
                context
                    .read<WeatherBloc>()
                    .add(FetchSuggestedLocations(query: value));
              },
              decoration: InputDecoration(
                hintText: 'search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.sort_rounded),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.9),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
              ),
              style: const TextStyle(height: 0.5),
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
                      log("loaded");
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
                                    "${location.name},${location.region!}"),
                                subtitle: Text(
                                  location.country!,
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

                    log("error");
                    return Container(
                      child: Center(
                          child: Text("Suggested cities will appear here")),
                    );
                  },
                )),
          )
        ]),
      ),
    );
  }
}
