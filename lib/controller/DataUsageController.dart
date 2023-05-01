import 'package:data_usage/data_usage.dart';
import 'package:get/get.dart';

class DataUsageController extends GetxController {
  var wifiOrData = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    DataUsage.init();
  }

  Future<List<DataUsageModel>> get wifiAppsList{
    return DataUsage.dataUsageAndroid(
        withAppIcon: true,
        dataUsageType: DataUsageType.wifi,
        oldVersion: false
    ).then((appsList) => _sortAppsByUsage(appsList));
  }

  Future<List<DataUsageModel>> get mobileAppsList{
    return DataUsage.dataUsageAndroid(
        withAppIcon: true,
        dataUsageType: DataUsageType.mobile,
        oldVersion: false
    ).then((appsList) => _sortAppsByUsage(appsList));
  }

  List<DataUsageModel> _sortAppsByUsage(List<DataUsageModel> appsList){
    appsList.sort( (a,b)=>b.sent!.compareTo(a.sent!) );
    appsList.sort( (a,b)=>b.received!.compareTo(a.received!) );
    return appsList;
  }
  String data_unit(int val){
    if(val < 1024){
      return "Bytes";
    }else if(val < 1024 * 1024){
      return "KB";
    }else if(val < 1024 * 1024 * 1024){
      return "MB";
    }else if(val < 1024 * 1024 * 1024 * 1024){
      return "GB";
    }else if(val < 1024 * 1024 * 1024 * 1024 * 1024){
      return "TB";
    }else{
      return "PB";
    }
  }
  num round_data(num val){
    while(val>1024){
      val = val / 1024 ;
    }
    return ((val * 100).roundToDouble() / 100);
  }
}
