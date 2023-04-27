import 'package:data_usage/data_usage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/DataUsageController.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';

class DataUsagePage extends StatelessWidget {
  final _dataUsageController = Get.put(DataUsageController());

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Data Usage".tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Mobile usage"),
                ObxValue(
                    (p0) => Switch(
                        value: _dataUsageController.wifiOrData.value,
                        activeColor: Colors.deepPurple,
                        inactiveThumbColor: Colors.blue,
                        inactiveTrackColor: Colors.lightBlueAccent,
                        onChanged: (val) {
                          _dataUsageController.wifiOrData.value = val;
                        }),
                    _dataUsageController.wifiOrData),
                Text("WIFI usage"),
              ],
            ),
            Obx(() {
              return FutureBuilder(
                  future: _dataUsageController.wifiOrData.value
                      ? _dataUsageController.wifiAppsList
                      : _dataUsageController.mobileAppsList,
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<DataUsageModel> appsList =
                            snapshot.data as List<DataUsageModel>;
                        return SizedBox(
                          width: double.infinity,
                          height: 620.0,
                          child: ListView(
                            itemExtent: 80.0,
                            children: [
                              ...appsList.map((app) {
                                num recvVal = _dataUsageController
                                    .round_data(app.received!);
                                String recvUnit = _dataUsageController
                                    .data_unit(app.received!);
                                num sentVal =
                                    _dataUsageController.round_data(app.sent!);
                                String sentUnit =
                                    _dataUsageController.data_unit(app.sent!);

                                return ListTile(
                                  title: Text(app.appName!),
                                  leading: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: MemoryImage(app.appIconBytes!),
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Received" +
                                          " : " +
                                          recvVal.toString() +
                                          " " +
                                          recvUnit),
                                      Text("Sent" +
                                          " : " +
                                          sentVal.toString() +
                                          " " +
                                          sentUnit),
                                    ],
                                  ),
                                  isThreeLine: true,
                                );
                              }).toList()
                            ],
                          ),
                        );
                      } else {
                        return Center(child: Text("Nothing to view"));
                      }
                    } else {
                      return Column(
                        children: [
                          SizedBox(height: 100.0),
                          CircularProgressIndicator(),
                        ],
                      );
                    }
                  });
            }),
          ],
        ),
      ),
    );
  }
}
