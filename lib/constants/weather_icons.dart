//     https://openweathermap.org/weather-conditions
/*


Day icon	Night icon	Description
01d.png 	01n.png 	clear sky
02d.png 	02n.png 	few clouds
03d.png 	03n.png 	scattered clouds
04d.png 	04n.png 	broken clouds
09d.png 	09n.png 	shower rain
10d.png 	10n.png 	rain
11d.png 	11n.png 	thunderstorm
13d.png 	13n.png 	snow
50d.png 	50n.png 	mist



*/

String getWeatherIcon(String iconId) {
//
  switch (iconId) {
    case '01d':
      return 'clear.png';

    case '01n':
      return 'clear_night.png';

    case '02d':
      return 'little_clouds.png';

    case '02n':
    case '03n':
      return 'cloudy_night.png';

    case '03d':
      return 'scattered_clouds.png';

    case '04d':
      return 'cloudy.png';

    case '09d':
    case '09n':
    case '10d':
    case '10n':
      return 'rain.png';

    case '11d':
      return 'thunderstorm.png';
    case '11n':
      return 'night_storm.png';

    default:
      return 'cloudy.png';
  }
}
