import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:pentor/model/mobile_network_info.dart';
import 'package:pentor/model/wifi_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityController extends GetxController {
  ConnectivityResult connectivityStatus = ConnectivityResult.none;
  bool _isInternetConnected = false;
  StreamSubscription? _connectivitySubscription, _internetSubscription;
  late InternetConnectionChecker internetConnectionChecker;

  @override
  void onInit() async {
    super.onInit();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      connectivityStatus = result;
      update();
    });
    internetConnectionChecker = InternetConnectionChecker.createInstance();
    _internetSubscription =
        internetConnectionChecker.onStatusChange.listen((event) {
      if (event == InternetConnectionStatus.connected) {
        _isInternetConnected = true;
      } else {
        _isInternetConnected = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription?.cancel();
    _internetSubscription?.cancel();
  }

  Future<WifiInfo> get getWifiInfo async {
    if (!await Permission.location.isGranted) {
      throw new LocationPermissionException();
    }
    return await WifiInfo.initWifiInfo();
  }

  Future<MobileNetworkInfo> get getMobileNetworkInfo async {
    if (!await Permission.phone.isGranted) {
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

  bool isInternetConnected() {
    return _isInternetConnected;
  }

  Future<bool> hasPhonePermission() {
    return Permission.phone.isGranted;
  }

  Future<bool> hasLocationPermission() {
    return Permission.location.isGranted;
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
