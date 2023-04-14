import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/LanScannerController.dart';
import 'package:pentor/model/device.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';

class LanScannerPage extends StatelessWidget {
  final LanScannerController _lanScannerController =
      Get.put(LanScannerController(), permanent: true);
  
  IconData getDevIcon(DeviceType type){
    IconData ico;
    switch(type){
      
      case DeviceType.None:
        ico = Icons.device_unknown_outlined;
        break;
      case DeviceType.Mobile:
        ico = Icons.android;
        break;
      case DeviceType.Computer:
        ico = Icons.computer;
        break;
      case DeviceType.Printer:
        ico = Icons.print;
        break;
      case DeviceType.Other:
        ico = Icons.devices;
        break;
    }
    return ico;
  }

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
                      SingleChildScrollView(child: Column(children: [
                        ..._lanScannerController.getDevicesList
                            .map((dev) => ListTile(
                          title: Text(dev.name),
                          subtitle: Text(dev.ip+"\n"+dev.mac),
                          leading: Icon(getDevIcon(dev.type),size: 40.0,),
                          isThreeLine: true,
                        ))
                            .toList(),
                      ],),)
                    ],
                  ))
        ],
      ),
    );
  }
}
