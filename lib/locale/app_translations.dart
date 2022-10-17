import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': _EN.messages,
        'ar': _AR.messages,
      };
}

class _EN {
  static Map<String, String> get messages => {
        'HOME_PAGE_TITLE': "Pentor | Home",
        'HOME_PAGE_COUNTER': "You have pushed the button this many times",
      };
}

class _AR {
  static Map<String, String> get messages => {
        'HOME_PAGE_TITLE': "بنتور | الرئيسية",
        'HOME_PAGE_COUNTER': "لقد ضغطت علي الزر هذا العدد من المرات",
      };
}
