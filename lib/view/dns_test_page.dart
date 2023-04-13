import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/DnsTestController.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';

class DnsTestPage extends StatelessWidget {
  const DnsTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("DNS Test".tr),
      ),
    );
  }
}
