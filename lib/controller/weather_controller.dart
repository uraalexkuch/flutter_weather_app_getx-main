import 'package:flutter_weather_app_getx/model/weather_model.dart';
import 'package:flutter_weather_app_getx/network/weather_repository.dart';
import 'package:get/get.dart';

enum Status { loading, success, error }

class WeatherController extends GetxController {
  final status = Status.loading.obs;
  final weatherResponse = Rx<WeatherModel>();

  @override
  void onInit() {
    //TODO remove hardcode, using use input or GPS
    fetchDataFromWeatherApi("Volnovakha");
    super.onInit();
  }

  @override
  void onReady() {
    ever(weatherResponse, (_) async {});
    super.onReady();
  }

  void searchWeatherByLocation(String city) {
    fetchDataFromWeatherApi(city);
  }

  Future<WeatherModel> getWeather(String cityName) async {
    try {
      var data = await WeatherRepository.instance.loadGlobalData(cityName);
      var res = WeatherModel.fromJson(data);
      print(res.timezone);
      return res;
    } on Exception catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<void> fetchDataFromWeatherApi(String cityName) async {
    return getWeather(cityName).then(
      (data) {
        weatherResponse(data);
        status(Status.success);
      },
      onError: (err) {
        print("$err");
        return status(Status.error);
      },
    );
  }
}
