import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weathery/screens/location_page.dart';
import 'package:weathery/services/location.dart';
import 'package:weathery/services/networking.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  static const apiKey = 'e09187b472b709042ac43643016c30f1';

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  void getWeatherData() async {
    Location location = Location();
    await location.findLocation();
    double longitude = location.longitude;
    double latitude = location.latitude;
    NetworkHandler networkHandler =
        NetworkHandler('https://api.openweathermap.org/data/2.5/'
            'weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    var weatherData = await networkHandler.getData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
