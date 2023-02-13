import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/PingTestController.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';

class PingTestPage extends StatelessWidget {
  const PingTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Ping Test".tr),
      ),
    );
  }
}
