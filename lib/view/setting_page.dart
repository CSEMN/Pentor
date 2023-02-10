import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/SettingController.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Settings".tr),
      ),
    );
  }
}
