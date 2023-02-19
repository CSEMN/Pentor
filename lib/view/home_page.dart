import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/ConnectivityController.dart';
import 'package:pentor/controller/HomePageController.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:pentor/model/mobile_network_info.dart';
import 'package:pentor/model/wifi_info.dart';
import 'package:pentor/themes.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';

class HomePage extends StatelessWidget {
  final _homeController = Get.put(HomePageController(), permanent: true);
  final _connectivityController = Get.find<ConnectivityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('HOME_PAGE_TITLE'.tr),
        ),
        body: Column(
          children: [
            GetBuilder<ConnectivityController>(builder: (_)=>connectivityWidget()),

          ],
        ));
  }

  Widget connectivityWidget() {
    switch (_connectivityController.connectivityStatus) {
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
        return buildWifiTile();
      case ConnectivityResult.mobile:
        return buildMobileInfoTile();
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

  Widget buildPermissionErrorWidget(String title,void Function() onTap) {
    return ListTile(
      tileColor: Themes.backgroundColor,
      leading: Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 50.0,
      ),
      onTap: onTap,
      title: Text(title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      subtitle: Text("Tap To Grant".tr),
    );
  }

  Widget buildWifiTile() {
    return FutureBuilder<WifiInfo>(
        future: _connectivityController.getWifiInfo,
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return buildPermissionErrorWidget(snapshot.error.toString(),
                _connectivityController.askForLocationPermission);
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                WifiInfo wifiInfo = snapshot.data!;
                return ExpansionTileCard(
                  expandedTextColor: Themes.primaryColor,
                  leading: Icon(
                    Icons.wifi,
                    size: 50.0,
                  ),
                  title: Text(wifiInfo.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text("WIFI Network Connection".tr),
                  children: [
                    wifiInfoTable(wifiInfo),
                  ],
                );
              default:
                //TODO: Other switch cases
                return Container();
            }
          }
        });
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

  Widget buildMobileInfoTile(){
    return FutureBuilder<MobileNetworkInfo>(
      future: _connectivityController.getMobileNetworkInfo,
        builder: (_,snapshot){
          if (snapshot.hasError) {
            return buildPermissionErrorWidget(snapshot.error.toString(),
                _connectivityController.askForPhonePermission);
          }else{
            switch(snapshot.connectionState){
              case ConnectionState.done:
                MobileNetworkInfo mobileNetworkInfo = snapshot.data!;
                return ExpansionTileCard(
                  expandedTextColor: Themes.primaryColor,
                  leading: Icon(
                    Icons.signal_cellular_alt,
                    size: 50.0,
                  ),
                  title: Text(mobileNetworkInfo.name,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text("Mobile Network Connection".tr),
                  children: [mobileNetworkInfoTable(mobileNetworkInfo)],
                );
              default:
              //TODO: Other switch cases
                return Container();

            }
          }


    });
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
