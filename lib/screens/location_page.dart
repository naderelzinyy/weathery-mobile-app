import 'package:flutter/material.dart';
import 'package:weathery/screens/city.dart';
import 'package:weathery/services/weather.dart';
import 'package:weathery/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int temperature;
  late String temperatureMessage;
  late String conditionIcon;
  late String cityName;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    print(widget.locationWeather);
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherInfo) {
    setState(() {
      if (weatherInfo == null ||
          (weatherInfo['coord']['lon'] == 0 &&
              weatherInfo['coord']['lat'] == 0)) {
        temperature = 0;
        temperatureMessage = "'Couldn't get weather data.";
        conditionIcon = '🚫';
        cityName = ' ';
        return;
      }
      temperature = weatherInfo['main']['temp'].toInt();
      temperatureMessage = weatherModel.getMessage(temperature);
      int condition = weatherInfo['weather'][0]['id'];
      conditionIcon = weatherModel.getWeatherIcon(condition);
      cityName = weatherInfo['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const NetworkImage(
                'https://images.unsplash.com/photo-1498015583783-4abcab4a760a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMTgwOTN8MHwxfHNlYXJjaHw0Mnx8Y2xvdWRzfGVufDB8fHx8MTY2ODUwNzc2Nw&ixlib=rb-4.0.3&q=80&w=1080'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.6), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherInfo = await weatherModel.getLocationWeather();
                      updateUI(weatherInfo);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedValue = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedValue != null) {
                        var cityWeatherInfo =
                            await weatherModel.getCityBasedWeather(typedValue);
                        updateUI(cityWeatherInfo);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      conditionIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$temperatureMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
