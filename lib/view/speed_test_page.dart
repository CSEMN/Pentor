import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/SpeedTestController.dart';
import 'package:pentor/themes.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';
import 'package:speedometer/speedometer.dart';

class SpeedTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Internet Speed Test".tr),
      ),
      body: Center(
        child: GetBuilder<SpeedTestController>(
          init: SpeedTestController(),
          builder: (controller) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 35.0,left: 30.0,right: 30.0,bottom: 5.0),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: SpeedOMeter(
                        start: controller.start,
                        end: controller.end,
                        highlightStart: 0.125,
                        highlightEnd: 0.875,
                        themeData: ThemeData(
                          primaryColor: Themes.primaryColor,
                          accentColor: Colors.black,
                          backgroundColor: Colors.grey,
                        ),
                        eventObservable: controller.eventObservable),
                  ),
                ),
                Text("Download".tr+" : " + controller.downSpeed.toString() +' '+ controller.downUnit.tr),
                Text("Upload".tr+" : " + controller.upSpeed.toString() +' '+ controller.upUnit.tr),
                ElevatedButton(onPressed: controller.speed_test, child: Text("Start".tr))
              ],
            );
          },
        ),
      ),
    );
  }
}
