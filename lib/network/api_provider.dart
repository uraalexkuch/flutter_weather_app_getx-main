import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_weather_app_getx/controller/api.dart' as apikey;
import 'package:http/http.dart' as http;

class ApiProvider {
  static final String baseUrl =
      "http://api.openweathermap.org/data/2.5/forecast";

  static Future<Map<String, dynamic>> getWeather(String cityName) async {
    final weatherFullUrl =
        baseUrl + "?q=$cityName&appid=${apikey.apiKey}&units=metric";

    var response = await http.get(weatherFullUrl);

    debugPrint("ApiProvider - response : ${response.body}");

    return _jsonResponse(response);
  }

  static Future<Map<String, dynamic>> _jsonResponse(
      http.Response response) async {
    final body = response.body ?? "";
    debugPrint(body);
    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      debugPrint(jsonBody.length);
      return jsonBody;
    } else {
      print("processResponse error");
      return {"error": true};
    }
  }
}
