import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/UserController.dart';
import 'package:pentor/themes.dart';
import 'package:pentor/controller/NavigationDrawer_Controller.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 10);
  final NavDrawerWidgetController _navController =
      Get.find<NavDrawerWidgetController>();
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Themes.customLightTheme.primaryColor,
        child: ListView(
          children: <Widget>[
            GetBuilder<UserController>(builder: (controller) {
              return buildHeader(
                  urlImage: _userController.user.photoURL ??
                      "https://cdn1.iconfinder.com/data/icons/crimes-and-justice/100/14-64.png",
                  name: _userController.user.displayName ?? "Anonymous".tr,
                  email: _userController.user.isAnonymous
                      ? "Guest Account".tr
                      : _userController.user.email ?? "Guest Account".tr,
                  onClicked: _navController.openDataUsagePage);
            }),
            Container(
              padding: padding,
              child: Column(
                children: [
                  GetBuilder<UserController>(builder: (controller) {
                    if (_userController.user.isAnonymous)
                      return OutlinedButton.icon(
                          icon: Icon(Icons.login),
                          onPressed: _userController.signInWithGoogle,
                          label: Text("Google Sign in".tr));
                    else
                      return OutlinedButton.icon(
                          icon: Icon(Icons.logout),
                          onPressed: _userController.signOut,
                          label: Text("Sign Out".tr));
                  }),
                  const SizedBox(height: 5),
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
                  buildMenuItem(
                      text: 'Network Logger'.tr,
                      icon: Icons.line_style,
                      onClicked: _navController.openNetworkLoggerPage),
                  Divider(color: Colors.white70),
                  buildMenuItem(
                      text: 'Settings'.tr,
                      icon: Icons.settings,
                      onClicked: _navController.openSettingsPage),
                  buildMenuItem(
                      text: 'SW LANG',
                      icon: Icons.language,
                      onClicked: () {
                        if (Get.locale!.languageCode == 'en')
                          Get.updateLocale(Locale('ar'));
                        else
                          Get.updateLocale(Locale('en'));
                      })
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
          padding: EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage),backgroundColor: Themes.accentColor,),
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
