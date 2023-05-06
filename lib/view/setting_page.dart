import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/SettingController.dart';
import 'package:pentor/locale/locale_controller.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';

class SettingPage extends StatelessWidget {
  final SettingController settingController = Get.find<SettingController>();
  final LocaleController localeCtrl = Get.find<LocaleController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text("Settings".tr),
        ),
        body: SizedBox(
          width: width,
          height: height,
          child: ListView(
            children: [
              ListTile(title: Text("General".tr), textColor: Colors.blue),
              buildLanguageTile(),
              buildThemeTile(),
            ],
          ),
        ));
  }

  GetBuilder<SettingController> buildThemeTile() {
    return GetBuilder<SettingController>(builder: (context) {
      return ListTile(
        title: Text("Theme".tr),
        subtitle: Text(settingController.theme_str.tr),
        leading: Icon(
          settingController.theme_str == 'light'
              ? Icons.light_mode
              : Icons.dark_mode,
          size: 40.0,
        ),
        onTap: settingController.switchTheme,
      );
    });
  }

  ListTile buildLanguageTile() {
    return ListTile(
      title: Text("Language".tr),
      leading: const Icon(Icons.language, size: 40.0),
      subtitle: GetBuilder<LocaleController>(builder: (_) {
        return Text(localeCtrl.language.tr);
      }),
      onTap: localeCtrl.switchLang,
    );
  }
}
