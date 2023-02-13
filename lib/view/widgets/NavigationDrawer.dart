import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/themes.dart';
import 'package:pentor/view/ping_test_page.dart';
import 'package:pentor/view/setting_page.dart';
import 'package:pentor/controller/NavigationDrawer_Controller.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 10);
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
              onClicked: () => NavDrawerWidgetController.OpenDataUsagePage()),

            Container(
              padding: padding,
              child: Column(
                children: [
                  Divider(color: Colors.white70),
                  buildMenuItem(
                      text: 'Home'.tr,
                      icon: Icons.home,
                      onClicked: () =>
                          NavDrawerWidgetController.OpenHomePage()
                  ),
                  buildMenuItem(
                      text: 'Data Usage'.tr,
                      icon: Icons.data_usage,
                      onClicked: () =>  NavDrawerWidgetController.OpenDataUsagePage()),
                  buildMenuItem(
                      text: 'DNS Test'.tr,
                      icon: Icons.dns,
                      onClicked: () => NavDrawerWidgetController.OpenDnsTestPage()
                  ),
                  buildMenuItem(
                      text: 'LAN Scanner'.tr,
                      icon: Icons.lan,
                      onClicked: () => NavDrawerWidgetController.OpenLanScannerPage()
                  ),
                  buildMenuItem(
                      text: 'Internet Speed Test'.tr,
                      icon: Icons.speed,
                      onClicked: () => NavDrawerWidgetController.OpenSpeedTestPage()
                  ),
                  buildMenuItem(
                      text: 'Ping Test'.tr,
                      icon: Icons.network_ping,
                      onClicked: () => Get.to( PingTestPage()
                      )
                  ),
                  Divider(color: Colors.white70),
                  buildMenuItem(
                      text: 'Settings'.tr,
                      icon: Icons.settings,
                      onClicked: () => Get.to( SettingPage()
                      )
                  ),
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


