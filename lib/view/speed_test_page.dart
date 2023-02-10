import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/SpeedTestController.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';

class SpeedTestPage extends StatelessWidget {
  const SpeedTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Internet Speed Test".tr),
      ),
    );
  }
}
