import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pentor/controller/ConnectivityController.dart';
import 'package:pentor/controller/NavigationDrawer_Controller.dart';
import 'package:pentor/controller/SettingController.dart';
import 'package:pentor/controller/UserController.dart';
import 'package:pentor/firebase_options.dart';
import 'package:pentor/locale/app_translations.dart';
import 'package:pentor/locale/locale_controller.dart';
import 'package:pentor/view/home_page.dart';
import 'package:get/get.dart';
import './themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //initialize firebase connection.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();//initialize GetX Storage AKA: Shared preferences
  Get.lazyPut(()=>UserController());
  Get.lazyPut(()=>NavDrawerWidgetController());
  Get.lazyPut(()=>ConnectivityController());
  Get.lazyPut(()=>LocaleController());
  Get.lazyPut(()=>SettingController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    LocaleController localeCtrl=Get.find<LocaleController>();
    SettingController settingCtrl=Get.find<SettingController>();
    return GetMaterialApp(
      title: 'Pentor',
      locale: localeCtrl.locale,
      fallbackLocale:  const Locale('en'),
      translations: AppTranslations(),
      theme: settingCtrl.theme,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
