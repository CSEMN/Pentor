import 'dart:async';

import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:pentor/model/mobile_network_info.dart';
import 'package:pentor/model/wifi_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomePageController extends GetxController {
  WifiInfo wifiInfo = WifiInfo();
  final NetworkInfo _networkInfo = NetworkInfo();
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  StreamSubscription? _connectivitySubscription;
  MobileNetworkInfo mobileNetworkInfo = MobileNetworkInfo();
  bool locationPermissionError=false,phonePermissionError=false;
  @override
  void onInit() async {
    super.onInit();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      connectivityResult = result;
      update();
      _checkConnection();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription?.cancel();
  }

  void _checkConnection() async {
      switch (connectivityResult) {
        case ConnectivityResult.wifi:
          if (await Permission.location.request().isGranted) {
            wifiInfo = await WifiInfo.initWifiInfo(_networkInfo);
          }else{
            this.locationPermissionError=true;
          }
          break;
        case ConnectivityResult.mobile:
          if (await Permission.phone.request().isGranted) {
            mobileNetworkInfo= await MobileNetworkInfo.initMobileNetInfo();
          }else{
            this.phonePermissionError=true;
          }

          break;
      }
    update();
  }
  Future<void> askForLocationPermission() async{
    var request = await Permission.location.request();
    if (request.isGranted) {
      this.locationPermissionError=false;
      update();

    }else if (request.isPermanentlyDenied){
      await openAppSettings();
    }
    this._checkConnection();
  }

  Future<void> askForPhonePermission() async{
    var request = await Permission.phone.request();
    if (request.isGranted) {
      this.phonePermissionError=false;
      update();
    }else if (request.isPermanentlyDenied){
      await openAppSettings();
    }
    this._checkConnection();
  }
}
