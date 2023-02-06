import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/HomePageController.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:pentor/model/mobile_network_info.dart';
import 'package:pentor/model/wifi_info.dart';
import 'package:pentor/themes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) => Scaffold(
            appBar: AppBar(
              title: Text('HOME_PAGE_TITLE'.tr),
            ),
            body: Column(
              children: [connectivityWidget(controller)],
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
        title: Text((controller.locationPermissionError
            ?'Location':'Phone') +" Permission Not Granted",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("Tap To Grant"),
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
            title: Text("NOT CONNECTED",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text("No Connection Found"),
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
            subtitle: Text("WIFI Network Connection"),
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
            subtitle: Text("Mobile Network Connection"),
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
            title: Text("ERROR",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text("CONNECTION ERROR"),
          );
      }
    }
  }

  Widget wifiInfoTable(WifiInfo wifiInfo) {
    return DataTable(columns: [
      DataColumn(
          label: Text('Field',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Value',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    ], rows: [
      DataRow(cells: [
        DataCell(Text('Name')),
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
        DataCell(Text('Gateway')),
        DataCell(Text(wifiInfo.gateway)),
      ]),
      DataRow(cells: [
        DataCell(Text('Broadcast')),
        DataCell(Text(wifiInfo.broadcast)),
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
          label: Text('Field',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Value',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    ], rows: [
      DataRow(cells: [
        DataCell(Text('Name')),
        DataCell(Text(mobileNetworkInfo.name)),
      ]),
      DataRow(cells: [
        DataCell(Text('Type')),
        DataCell(Text(mobileNetworkInfo.networkType)),
      ]),
      DataRow(cells: [
        DataCell(Text('Strength')),
        DataCell(Text(mobileNetworkInfo.signalStrength)),
      ]),
    ]);
  }
}
