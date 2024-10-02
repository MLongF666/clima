import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/location_screen.dart';
import 'location.dart';
import 'networking.dart';
const apiKey = 'SdXKkEEoWtBaJHRHp';

class WeatherModel {
  String getWeatherIcon(String text) {
    if (text.contains('小雨')) {
      return '🌩';
    } else if (text.contains('中雨')) {
      return '🌧';
    } else if (text.contains('大雨')) {
      return '☔️';
    } else if (text.contains('雪')) {
      return '☃️';
    } else if (text.contains('洪')) {
      return '🌫';
    } else if (text.contains('晴')) {
      return '☀️';
    } else if (text.contains('多云')||text.contains('阴')) {
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
  getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    var networkingHelper = NetworkingHelper(
        'https://api.seniverse.com/v3/weather/now.json?key=$apiKey&location=${location.latitude}:${location.longitude}&language=zh-Hans&unit=c');
    return await networkingHelper.getData();
  }

  getCityWeather(String cityName) async {
    var networkingHelper = NetworkingHelper(
        'https://api.seniverse.com/v3/weather/now.json?key=$apiKey&location=$cityName&language=zh-Hans&unit=c');
    return await networkingHelper.getData();
  }
}
