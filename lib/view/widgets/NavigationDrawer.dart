import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/themes.dart';
import 'package:pentor/view/ping_test_page.dart';
import 'package:pentor/view/setting_page.dart';
import 'package:pentor/controller/NavigationDrawer_Controller.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 10);
  final _navController = Get.put(NavDrawerWidgetController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final name = 'Ahmed';
    final email = 'Ahmed@abs.com';
    final urlImage =
        "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1031&q=80";
    return Drawer(
      child: Material(
        color: Themes.customLightTheme.primaryColor,
        child: ListView(
          children: <Widget>[
            buildHeader(
                urlImage: urlImage,
                name: name,
                email: email,
                onClicked: _navController.openDataUsagePage),
            Container(
              padding: padding,
              child: Column(
                children: [
                  Divider(color: Colors.white70),
                  buildMenuItem(
                      text: 'Home'.tr,
                      icon: Icons.home,
                      onClicked: _navController.openHomePage),
                  buildMenuItem(
                      text: 'Data Usage'.tr,
                      icon: Icons.data_usage,
                      onClicked: _navController.openDataUsagePage),
                  buildMenuItem(
                      text: 'DNS Test'.tr,
                      icon: Icons.dns,
                      onClicked: _navController.openDnsTestPage),
                  buildMenuItem(
                      text: 'LAN Scanner'.tr,
                      icon: Icons.lan,
                      onClicked: _navController.openLanScannerPage),
                  buildMenuItem(
                      text: 'Internet Speed Test'.tr,
                      icon: Icons.speed,
                      onClicked: _navController.openSpeedTestPage),
                  buildMenuItem(
                      text: 'Ping Test'.tr,
                      icon: Icons.network_ping,
                      onClicked: _navController.openPingTestPage),
                  Divider(color: Colors.white70),
                  buildMenuItem(
                      text: 'Settings'.tr,
                      icon: Icons.settings,
                      onClicked: _navController.openSettingsPage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        child: Container(
          color: Themes.customLightTheme.primaryColor,
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: textStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: textStyle),
      onTap: onClicked,
    );
  }
}
