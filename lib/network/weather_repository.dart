import 'package:flutter_weather_app_getx/network/api_provider.dart';

class WeatherRepository {
  static WeatherRepository instance = WeatherRepository();
  Future<Map<String, dynamic>> loadGlobalData(cityName) {
    return ApiProvider.getWeather(cityName);
  }
}
