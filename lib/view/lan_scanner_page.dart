import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/LanScannerController.dart';
import 'package:pentor/model/device.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';

class LanScannerPage extends StatelessWidget {
  final LanScannerController _lanScannerController =
      Get.put(LanScannerController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("LAN Scanner".tr),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          ElevatedButton(
              onPressed: _lanScannerController.scanNetwork,
              child: Text("SCAN NOW")),
          GetBuilder<LanScannerController>(
              builder: (_) => Column(
                    children: [
                      Text(
                          "Found (${_lanScannerController.getDevicesList.length}) Devices !\n"),
                      ..._lanScannerController.getDevicesList.map((dev) => Text(dev.name + ' :\t ' + dev.ip)).toList(),
                    ],
                  ))
        ],
      ),
    );
  }
}
