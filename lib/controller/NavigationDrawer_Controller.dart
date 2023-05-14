import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:pentor/controller/ConnectivityController.dart';
import 'package:pentor/view/home_page.dart';
import 'package:pentor/view/lan_scanner_page.dart';
import 'package:pentor/view/network_logger_page.dart';
import 'package:pentor/view/ping_test_page.dart';
import 'package:pentor/view/setting_page.dart';
import 'package:pentor/view/speed_test_page.dart';
import '../view/data_usage_page.dart';
import '../view/dns_test_page.dart';
import 'package:get/get.dart';

final textStyle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Colors.white);

class NavDrawerWidgetController extends GetxController {
  final PageController pageController =
      PageController(initialPage: 1, keepPage: true);

  final ConnectivityController connectivityCtrl =
      Get.find<ConnectivityController>();

  late final List<NavPage> pages;

  NavDrawerWidgetController() {
    pages = [
      NavPage(
          'Data Usage', Icons.data_usage, openDataUsagePage, Colors.deepOrange),
      NavPage('DNS Test', Icons.dns, openDnsTestPage, Colors.teal),
      NavPage('LAN Scanner', Icons.lan, openLanScannerPage, Colors.deepPurple),
      NavPage(
          'Internet Speed Test', Icons.speed, openSpeedTestPage, Colors.pink),
      NavPage('Ping Test', Icons.network_ping, openPingTestPage, Colors.amber),
      NavPage('Network Logger', Icons.line_style, openNetworkLoggerPage,
          Colors.blue),
      NavPage('Settings', Icons.settings, openSettingsPage, Colors.brown),
    ];
  }

  @override
  void onInit() {
    super.onInit();
  }

  void openDataUsagePage() async {
    //need phone permission
    bool hasPhonePermission = await connectivityCtrl.hasPhonePermission();
    if (hasPhonePermission) {
      Get.off(() => DataUsagePage());
    } else {
      Get.snackbar(
        "Data Usage",
        "Data Usage Needs phone Permission",
        icon: Icon(Icons.perm_device_info_sharp),
        snackPosition: SnackPosition.BOTTOM,
      );
      connectivityCtrl.askForPhonePermission();
    }
  }

  void openHomePage() {
    Get.off(() => HomePage());
  }

  void openLanScannerPage() async {
    //need wifi connection and Location Permission
    bool hasLocationPermission = await connectivityCtrl.hasLocationPermission();
    if (hasLocationPermission) {
      if (connectivityCtrl.connectivityStatus == ConnectivityResult.wifi) {
        Get.off(() => LanScannerPage());
      } else {
        Get.snackbar(
          "Lan Scanner",
          "Lan Scanner Needs Wifi Connection",
          icon: Icon(Icons.wifi_off),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        "Lan Scanner",
        "Lan Scanner Needs Location Permission",
        icon: Icon(Icons.perm_scan_wifi_sharp),
        snackPosition: SnackPosition.BOTTOM,
      );
      connectivityCtrl.askForLocationPermission();
    }
  }

  void openDnsTestPage() async {
    //need Internet
    bool hasInternetConnection = connectivityCtrl.isInternetConnected();
    if (hasInternetConnection) {
      Get.off(() => DnsTestPage());
    } else {
      Get.snackbar(
        "DNS Test",
        "DNS Test Needs Internet connection",
        icon: Icon(Icons.signal_wifi_connected_no_internet_4),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void openPingTestPage() async {
    //need internet connection
    bool hasInternetConnection = connectivityCtrl.isInternetConnected();
    if (hasInternetConnection) {
      Get.off(() => PingTestPage());
    } else {
      Get.snackbar(
        "Ping Test",
        "Ping Test Needs Internet connection",
        icon: Icon(Icons.signal_wifi_connected_no_internet_4),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void openSpeedTestPage() async {
    //need internet connection
    bool hasInternetConnection = connectivityCtrl.isInternetConnected();
    if (hasInternetConnection) {
      Get.off(() => SpeedTestPage());
    } else {
      Get.snackbar(
        "Speed Test",
        "Speed Test Needs Internet connection",
        icon: Icon(Icons.signal_wifi_connected_no_internet_4),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void openNetworkLoggerPage() {
    Get.off(() => NetworkLoggerPage());
  }

  void openSettingsPage() {
    Get.off(() => SettingPage());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class NavPage {
  String title;
  IconData icon;
  void Function()? action;
  MaterialColor color;

  NavPage(this.title, this.icon, this.action, this.color);
}
