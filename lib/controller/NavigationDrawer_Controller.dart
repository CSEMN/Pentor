
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
    Get.off(()=>DataUsagePage());
  }

  static OpenHomePage() {
    Get.off(()=>HomePage());
  }

  static OpenLanScannerPage() {
    Get.off(()=>LanScannerPage());
  }
  static OpenDnsTestPage() {
    Get.off(()=>DnsTestPage());
  }
  static OpenPingTestPage() {
    Get.off(()=>PingTestPage());
  }
  static OpenSpeedTestPage() {
    Get.off(()=>SpeedTestPage());
  }
  static OpenSettingsPage() {
    Get.off(()=>SettingPage());
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
