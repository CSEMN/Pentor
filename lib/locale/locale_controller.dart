import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleController extends GetxController {
  static const String _langKey = "LANG";
  final localStorage = GetStorage();
  Locale _locale = const Locale('en');

  LocaleController() {
    if (localStorage.hasData(_langKey))
      _locale = Locale(localStorage.read(_langKey));
    else
      _locale = Get.deviceLocale!;
  }

  void changeLang(String langCode) {
    _locale = Locale(langCode);
    localStorage.write(_langKey, langCode);
    Get.updateLocale(_locale);
    update();
  }

  void switchLang() {
    if (_locale.languageCode == 'en')
      changeLang('ar');
    else
      changeLang('en');
  }

  Locale get locale {
    return _locale;
  }

  String get language {
    return _locale.languageCode == 'en' ? "English" : "Arabic";
  }
}
