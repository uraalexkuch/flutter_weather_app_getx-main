import 'package:flutter/material.dart';
import 'package:flutter_weather_app_getx/controller/bindings/weather_bind.dart';
import 'package:flutter_weather_app_getx/ui/index.dart';
import 'package:flutter_weather_app_getx/ui/weather_screen.dart';
import 'package:get/get.dart';

void main() {
  // WeatherBind().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [GetPage(name: '/', page: () => IndexPage())],
    );
  }
}
