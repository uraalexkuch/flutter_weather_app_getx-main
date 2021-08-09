import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app_getx/controller/weather_controller.dart';
import 'package:get/get.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherScreen extends GetView<WeatherController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "SIMPLE WEATHER APP",
          style: TextStyle(color: Colors.white, letterSpacing: 5, fontSize: 30),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
            ),
            onPressed: () {
              controller.onInit();
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Row(
          children: [
            Obx(() {
              final status = controller.status.value;
              if (status == Status.loading) return CircularProgressIndicator();
              if (status == Status.error)
                return Text('Loading weather error :(');
              if (status == Status.success)
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(2),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.weatherResponse.value.name,
                            style: TextStyle(fontSize: 35, color: Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // margin: EdgeInsets.all(2),
                              height: MediaQuery.of(context).size.height * 0.10,
                              width: MediaQuery.of(context).size.width * 0.25,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'http://openweathermap.org/img/wn/${controller.weatherResponse.value.weather[0].icon}@2x.png'),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                WindIcon(
                                  degree:
                                      controller.weatherResponse.value.wind.deg,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                AutoSizeText(
                                  controller.weatherResponse.value.wind.speed
                                          .toStringAsFixed(0) +
                                      " kmph",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                controller.weatherResponse.value.main.feelsLike
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white))
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('L: ',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                    Text(
                                        controller
                                            .weatherResponse.value.main.tempMin
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white))
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('H: ',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                    Text(
                                        controller
                                            .weatherResponse.value.main.tempMax
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
            })
          ],
        ),
      ),
    );
  }
}
