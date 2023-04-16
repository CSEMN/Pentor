import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/network_logger_controller.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';

class NetworkLoggerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NetworkLoggerController netLogCtrl =
        Get.put(NetworkLoggerController(context));
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Network Logger".tr),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Example 1'),
            subtitle: Text('Flutter website'),
            onTap: netLogCtrl.example1,
          ),
          ListTile(
            title: Text('Example 2'),
            subtitle: Text('Json placeholder'),
            onTap: netLogCtrl.example2,
          ),
          ListTile(
            title: Text('Example 3'),
            subtitle: Text('404 or something else'),
            onTap: netLogCtrl.example3,
          ),
          ListTile(
            title: Text('Example 4'),
            subtitle: Text('Mock api'),
            onTap: netLogCtrl.example4,
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: ElevatedButton(
              onPressed: netLogCtrl.openLogger,
              child: Text("Open Logger".tr),
            ),
          )
        ],
      ),
    );
  }
}
