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
        'Field': "Field",
        'Value': "Value",
        'Name': "Name",
        'Gateway': "Gateway",
        'Broadcast': "Broadcast",
        'Type': "Type",
        'Strength': "Strength",
        'NONE_OR_UNKNOWN': "Unknown",
        'POOR': "POOR",
        'MODERATE': "MODERATE",
        'GOOD': "GOOD",
        'GREAT': "GREAT",
    'Location Permission Not Granted': "Location Permission Not Granted",
    'Phone Permission Not Granted': "Phone Permission Not Granted",
        'Tap To Grant': "Tap To Grant",
        'NOT CONNECTED': "NOT CONNECTED",
        'No Connection Found': "No Connection Found",
        'WIFI Network Connection': "WIFI Network Connection",
        'Mobile Network Connection': 'Mobile Network Connection',
        'ERROR': "ERROR",
        'CONNECTION ERROR': 'CONNECTION ERROR',
      };
}

class _AR {
  static Map<String, String> get messages => {
        'HOME_PAGE_TITLE': "بنتور | الرئيسية",
        'Field': "حقل",
    'Value': "القيمة",
    'Name': "الاسم",
    'Gateway': "البوابة",
    'Broadcast': "الاذاعة",
    'Type': "النوع",
    'Strength': "القوة",
    'NONE_OR_UNKNOWN': "غير معروف",
    'POOR': "ضعيف",
    'MODERATE': "متوسط",
    'GOOD': "جيد",
    'GREAT': "ممتاز",
    'Location Permission Not Granted': "لم يتم الحصول علي صلاحيات العنوان",
    'Phone Permission Not Granted': "لم يتم الحصول علي صلاحيات الهاتف",
    'Tap To Grant': "انقر للحصول",
    'NOT CONNECTED': "غير متصل",
    'No Connection Found': "لا يوجد اتصال",
    'WIFI Network Connection': "اتصال شبكة الوايفاي",
    'Mobile Network Connection': 'اتصال شبكة الهاتف',
    'ERROR': "خطأ",
    'CONNECTION ERROR': 'خطأ في الاتصال',
      };
}
