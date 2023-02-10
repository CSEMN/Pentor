import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/LanScannerController.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';

class LanScannerPage extends StatelessWidget {
  const LanScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("LAN Scanner".tr),
      ),
    );
  }
}
