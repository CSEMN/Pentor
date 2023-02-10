
import 'package:flutter/material.dart';
import 'package:pentor/view/home_page.dart';
import 'package:pentor/view/lan_scanner_page.dart';
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

  @override
  void onInit() {
    super.onInit();
  }

  static OpenDataUsagePage() {
    Get.to(DataUsagePage());
  }

  static OpenHomePage() {
    Get.to(HomePage());
  }

  static OpenLanScannerPage() {
    Get.to(LanScannerPage());
  }
  static OpenDnsTestPage() {
    Get.to(DnsTestPage());
  }
  static OpenPingTestPage() {
    Get.to(PingTestPage());
  }
  static OpenSpeedTestPage() {
    Get.to(SpeedTestPage());
  }
  static OpenSettingsPage() {
    Get.to(SettingPage());
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
