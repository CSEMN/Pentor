import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pentor/themes.dart';

class SettingController extends GetxController {
  static const String _themeKey = "THEME";
  final localStorage = GetStorage();

  ThemeData _theme = Themes.customLightTheme;

  SettingController() {
    if (localStorage.hasData(_themeKey)) {
      String themeFromStorage = localStorage.read(_themeKey);
      if (themeFromStorage == "light")
        _theme = Themes.customLightTheme;
      else
        _theme = Themes.customDarkTheme;
    } else {
      _theme = Themes.customLightTheme;
    }
  }

  void switchTheme() {
    if (_theme == Themes.customLightTheme) {
      _theme = Themes.customDarkTheme;
      localStorage.write(_themeKey, 'dark');
    } else {
      _theme = Themes.customLightTheme;
      localStorage.write(_themeKey, 'light');
    }
    Get.changeTheme(_theme);
    update();
  }

  ThemeData get theme {
    return _theme;
  }

  String get theme_str {
    return _theme == Themes.customLightTheme ? "light" : "dark";
  }
}
