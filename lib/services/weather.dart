import 'package:weathery/services/location.dart';
import 'package:weathery/services/networking.dart';

class WeatherModel {
  static const apiKey = 'e09187b472b709042ac43643016c30f1';

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.findLocation();
    double longitude = location.longitude;
    double latitude = location.latitude;
    NetworkHandler networkHandler =
        NetworkHandler('https://api.openweathermap.org/data/2.5/'
            'weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    var weatherData = await networkHandler.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
