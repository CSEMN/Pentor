import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleController extends GetxController {
  static const String _langKey = "LANG";
  final localStorage = GetStorage();

  Locale initialLocale = const Locale('en');

  LocaleController() {
    Locale locale;
    if (localStorage.hasData(_langKey)) {
      locale = Locale(localStorage.read(_langKey));
    } else {
      locale = Get.deviceLocale!;
    }
    initialLocale = locale;
  }

  void changeLang(String langCode) {
    Locale locale = Locale(langCode);
    localStorage.write(_langKey, langCode);
    Get.updateLocale(locale);
  }
}
