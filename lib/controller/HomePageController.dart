import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:pentor/model/wifi_info.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePageController extends GetxController {
  WifiInfo wifiInfo = WifiInfo();
  final NetworkInfo _networkInfo = NetworkInfo();

  @override
  void onInit() async {
    super.onInit();
    _checkPermissions();

  }

  void _checkPermissions() async{
    if ( await Permission.location.request().isGranted) {
      wifiInfo = await WifiInfo.initWifiInfo(_networkInfo);
      update();
    }
  }

}
