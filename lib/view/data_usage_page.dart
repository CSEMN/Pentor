import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/DataUsageController.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';

class DataUsagePage extends StatelessWidget {
  const DataUsagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Data Usage".tr),
      ),
    );
  }
}
