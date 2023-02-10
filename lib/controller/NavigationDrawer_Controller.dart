import 'package:flutter/material.dart';
import 'package:pentor/view/home_page.dart';
import 'package:pentor/view/lan_scanner_page.dart';
import 'package:pentor/view/ping_test_page.dart';
import 'package:pentor/view/setting_page.dart';
import 'package:pentor/view/speed_test_page.dart';
import '../view/data_usage_page.dart';
import '../view/dns_test_page.dart';

final textStyle=TextStyle(fontFamily: 'Roboto',
fontWeight: FontWeight.w400,
fontSize: 14,
color: Colors.white);

void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();

  switch (index) {
    case 0:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
      break;
    case 1:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DataUsagePage(),
      ));
      break;
    case 2:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DnsTestPage(),
      ));
      break;
    case 3:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LanScannerPage(),
      ));
      break;
    case 4:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SpeedTestPage(),
      ));
      break;
    case 5:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PingTestPage(),
      ));
      break;
    case 6:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SettingPage(),
      ));
      break;

  }

}
