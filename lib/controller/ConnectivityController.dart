import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:pentor/model/mobile_network_info.dart';
import 'package:pentor/model/wifi_info.dart';
import 'package:permission_handler/permission_handler.dart';

class ConnectivityController extends GetxController {
  ConnectivityResult connectivityStatus = ConnectivityResult.none;
  StreamSubscription? _connectivitySubscription;

  @override
  void onInit() async {
    super.onInit();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      connectivityStatus = result;
      update();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription?.cancel();
  }

  Future<WifiInfo> get getWifiInfo async{
    if (! await Permission.location.isGranted) {
      throw new LocationPermissionException();
    }
    return await WifiInfo.initWifiInfo();
  }

  Future<MobileNetworkInfo> get getMobileNetworkInfo async{
    if (! await Permission.phone.isGranted) {
      throw new PhonePermissionException();
    }
    return await MobileNetworkInfo.initMobileNetInfo();
  }

  Future<void> askForLocationPermission() async {
    var request = await Permission.location.request();
    if (request.isGranted) {
      update();
    } else if (request.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  Future<void> askForPhonePermission() async {
    var request = await Permission.phone.request();
    if (request.isGranted) {
      update();
    } else if (request.isPermanentlyDenied) {
      await openAppSettings();
    }
  }
}

class PermissionException implements Exception {
  final String permissionType;

  PermissionException(this.permissionType);

  @override
  String toString() {
    return "$permissionType Permission Not Granted".tr;
  }
}

class PhonePermissionException extends PermissionException {
  PhonePermissionException() : super('Phone');
}

class LocationPermissionException extends PermissionException {
  LocationPermissionException() : super('Location');
}
