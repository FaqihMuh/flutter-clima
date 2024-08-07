import 'dart:ffi';

import '../services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'your apiKey';
const website = 'api.openweathermap.org';
const webPath = '/data/2.5/weather';

class WeatherModel {
  String units = 'metric';

  Future getCityWeather(String cityName) async {
    var cityURL = Uri.https('$website', '$webPath', {
      'q': '$cityName',
      'appid': '$apiKey',
      'units': '$units',
    });
    NetWorkHelper networkHelper = NetWorkHelper(url: cityURL);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    var currentURL = Uri.https('$website', '$webPath', {
      'lat': '${location.latitude}',
      'lon': '${location.longitude}',
      'appid': '$apiKey',
      'units': '$units',
    });
    NetWorkHelper networkHelper = NetWorkHelper(url: currentURL);

    var weatherData = await networkHelper.getData();
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
