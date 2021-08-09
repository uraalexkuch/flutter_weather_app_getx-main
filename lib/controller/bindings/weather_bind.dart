import 'package:flutter_weather_app_getx/controller/weather_controller.dart';
import 'package:get/get.dart';

class WeatherBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeatherController());
  }
}
