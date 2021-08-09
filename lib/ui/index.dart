import 'package:flutter/material.dart';
import 'package:flutter_weather_app_getx/controller/weather_controller.dart';
import 'package:flutter_weather_app_getx/model/weather_model.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List filteredUsers = <WeatherModel>[];

  WeatherController controller = WeatherController();

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Онлайн помічник'),
          ),
          body: Obx(() {
            final status = controller.status.value;
            if (status == Status.loading) return CircularProgressIndicator();
            if (status == Status.error) return Text('Loading weather error :(');
            if (status == Status.success)
              return Column(children: [
                Container(
                    decoration: BoxDecoration(
                      color: HexColor("#005BAA"),
                    ),
                    width: 100.w,
                    child: buildListView()),
              ]);
          }));
    });
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        //Vac vac = vacancy[index];
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: HexColor('#FFD947'), width: 5),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                elevation: 20,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/choicegromad/vacancy/detail',
                        arguments: controller.weatherResponse.value.name);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 28.w,
                                  child: Text(
                                    "Посада:",
                                    style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                    softWrap: true,
                                  )),
                            ),
                            Container(
                                width: 52.w,
                                child: Text(
                                  controller.weatherResponse.value.name,
                                  style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                  softWrap: true,
                                )),
                          ]),
                          Divider(),
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 28.w,
                                  child: Text(
                                    'Заробітна плата',
                                    style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                    softWrap: true,
                                  )),
                            ),
                            Container(
                                width: 47.w,
                                child: Text(
                                  controller.weatherResponse.value.wind.speed
                                          .toStringAsFixed(0) +
                                      " kmph",
                                  style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                  softWrap: true,
                                )),
                            Container(
                                width: 5.w,
                                child: Icon(Icons.arrow_forward_rounded)),
                          ]),
                        ],
                      ),
                    ),
                  ),
                )));
      },
    );
  }
}
