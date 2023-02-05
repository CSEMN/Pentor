import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/HomePageController.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
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
              children: [
                ExpansionTileCard(
                  expandedTextColor: Themes.primaryColor,
                  leading: Icon(
                    Icons.wifi,
                    size: 50.0,
                  ),
                  title: Text(controller.wifiInfo.name!),
                  subtitle: Text("WIFI Connection"),
                  children: [
                    wifiInfoTable(controller.wifiInfo),
                  ],
                )
              ],
            )));
  }

  Widget wifiInfoTable(WifiInfo wifiInfo) {
    return DataTable(
        columns: [
      DataColumn(
          label: Text('Field',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Value',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    ], rows: [
      DataRow(cells: [
        DataCell(Text('Name')),
        DataCell(Text(wifiInfo.name!)),
      ]),
      DataRow(cells: [
        DataCell(Text('IPv4')),
        DataCell(Text(wifiInfo.ipv4!)),
      ]),
      DataRow(cells: [
        DataCell(Text('Subnet')),
        DataCell(Text(wifiInfo.subnet!)),
      ]),
      DataRow(cells: [
        DataCell(Text('IPv6')),
        DataCell(Text(wifiInfo.ipv6!)),
      ]),
      DataRow(cells: [
        DataCell(Text('Gateway')),
        DataCell(Text(wifiInfo.gateway!)),
      ]),
      DataRow(cells: [
        DataCell(Text('Broadcast')),
        DataCell(Text(wifiInfo.broadcast!)),
      ]),
      DataRow(cells: [
        DataCell(Text('BSSID')),
        DataCell(Text(wifiInfo.bssid!)),
      ]),
    ]);
  }
}
