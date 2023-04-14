import 'package:arp_scanner/arp_scanner.dart';
import 'package:arp_scanner/device.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mac_address/mac_address.dart';
import 'package:pentor/controller/ConnectivityController.dart';
import 'package:pentor/model/device.dart';
import 'package:pentor/model/wifi_info.dart';

class LanScannerController extends GetxController {
  final _connectivityController = Get.find<ConnectivityController>();
  final List<NetworkDevice> _devicesList = [];
  WifiInfo _wifiInfo = WifiInfo();

  @override
  void onInit() async {
    super.onInit();
    this._wifiInfo = await _connectivityController.getWifiInfo;
  }

  void addDevice(NetworkDevice device) {
    _devicesList.add(device);
    update();
  }

  List<NetworkDevice> get getDevicesList {
    return _devicesList;
  }

  void scanNetwork() async {
    _devicesList.clear();
    String? mac = await GetMac.macAddress;
    ArpScanner.onScanning.listen((Device device) async {
      if (device.ip == this._wifiInfo.ipv4)
        addDevice(NetworkDevice('My Device', device.ip!, DeviceType.Mobile,mac!));
      else
        addDevice(NetworkDevice('', device.ip!));
    });
    ArpScanner.onScanFinished.listen((List<Device> devices) {
      Fluttertoast.showToast(msg: "Found ( ${devices.length} ) Devices");
    });
    ArpScanner.scan();
  }
}
