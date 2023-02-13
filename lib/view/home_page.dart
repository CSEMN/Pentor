import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/HomePageController.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:pentor/model/mobile_network_info.dart';
import 'package:pentor/model/wifi_info.dart';
import 'package:pentor/themes.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';

class HomePage extends StatelessWidget {
  final _homeController = Get.put(HomePageController(),permanent: true);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) => Scaffold(
          drawer: NavigationDrawerWidget(),
            appBar: AppBar(
              title: Text('HOME_PAGE_TITLE'.tr),
            ),
            body: Column(
              children: [
                connectivityWidget(_homeController),
              ],
            )));
  }

  Widget connectivityWidget(HomePageController controller) {
    if (controller.locationPermissionError || controller.phonePermissionError) {
      return ListTile(
        tileColor: Themes.backgroundColor,
        leading: Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 50.0,
        ),
        onTap: () {
          controller.locationPermissionError
              ? controller.askForLocationPermission()
              : controller.askForPhonePermission();
        },
        title: Text(
            (controller.locationPermissionError
                ? 'Location Permission Not Granted'.tr
                : 'Phone Permission Not Granted'.tr),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("Tap To Grant".tr),
      );
    } else {
      switch (controller.connectivityResult) {
        case ConnectivityResult.none:
          return ListTile(
            tileColor: Themes.backgroundColor,
            leading: Icon(
              Icons.not_interested,
              size: 50.0,
            ),
            title: Text("NOT CONNECTED".tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text("No Connection Found".tr),
          );
        case ConnectivityResult.wifi:
          return ExpansionTileCard(
            expandedTextColor: Themes.primaryColor,
            leading: Icon(
              Icons.wifi,
              size: 50.0,
            ),
            title: Text(controller.wifiInfo.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text("WIFI Network Connection".tr),
            children: [
              wifiInfoTable(controller.wifiInfo),
            ],
          );
        case ConnectivityResult.mobile:
          return ExpansionTileCard(
            expandedTextColor: Themes.primaryColor,
            leading: Icon(
              Icons.signal_cellular_alt,
              size: 50.0,
            ),
            title: Text(controller.mobileNetworkInfo.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text("Mobile Network Connection".tr),
            children: [mobileNetworkInfoTable(controller.mobileNetworkInfo)],
          );
        default:
          return ListTile(
            tileColor: Themes.accentColor,
            leading: Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 50.0,
            ),
            title: Text("ERROR".tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text("CONNECTION ERROR".tr),
          );
      }
    }
  }

  Widget wifiInfoTable(WifiInfo wifiInfo) {
    return DataTable(columns: [
      DataColumn(
          label: Text('Field'.tr,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Value'.tr,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    ], rows: [
      DataRow(cells: [
        DataCell(Text('Name'.tr)),
        DataCell(Text(wifiInfo.name)),
      ]),
      DataRow(cells: [
        DataCell(Text('IPv4')),
        DataCell(Text(wifiInfo.ipv4)),
      ]),
      DataRow(cells: [
        DataCell(Text('Subnet')),
        DataCell(Text(wifiInfo.subnet)),
      ]),
      DataRow(cells: [
        DataCell(Text('IPv6')),
        DataCell(Text(wifiInfo.ipv6)),
      ]),
      DataRow(cells: [
        DataCell(Text('Gateway'.tr)),
        DataCell(Text(wifiInfo.gateway)),
      ]),
      DataRow(cells: [
        DataCell(Text('Broadcast'.tr)),
        DataCell(Text(wifiInfo.broadcast.toString().replaceAll('/', ''))),
      ]),
      DataRow(cells: [
        DataCell(Text('BSSID')),
        DataCell(Text(wifiInfo.bssid)),
      ]),
    ]);
  }

  Widget mobileNetworkInfoTable(MobileNetworkInfo mobileNetworkInfo) {
    return DataTable(columns: [
      DataColumn(
          label: Text('Field'.tr,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Value'.tr,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    ], rows: [
      DataRow(cells: [
        DataCell(Text('Name'.tr)),
        DataCell(Text(mobileNetworkInfo.name)),
      ]),
      DataRow(cells: [
        DataCell(Text('Type'.tr)),
        DataCell(Text(mobileNetworkInfo.networkType)),
      ]),
      DataRow(cells: [
        DataCell(Text('Strength'.tr)),
        DataCell(Text(mobileNetworkInfo.signalStrength.tr)),
      ]),
    ]);
  }
}
