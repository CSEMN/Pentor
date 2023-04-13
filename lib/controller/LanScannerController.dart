import 'dart:async';
import 'dart:io';

import 'package:arp_scanner/arp_scanner.dart';
import 'package:arp_scanner/device.dart';
import 'package:get/get.dart';
import 'package:lan_scanner/lan_scanner.dart';
import 'package:pentor/controller/ConnectivityController.dart';
import 'package:pentor/model/device.dart';
import 'package:pentor/model/wifi_info.dart';
import 'package:pentor/utils/arp.dart';

class LanScannerController extends GetxController {
  final _connectivityController = Get.find<ConnectivityController>();
  final List<NetworkDevice> _devicesList = [];
  WifiInfo _wifiInfo= WifiInfo();
  @override
  void onInit() async{
    super.onInit();
    this._wifiInfo = await _connectivityController.getWifiInfo;
    // scanNetwork();

  }

  Future<String> getMacAddressForIP(String ipAddress) async {
    InternetAddress targetAddress = InternetAddress(ipAddress);
    InternetAddress localAddress = InternetAddress.anyIPv4;
    RawDatagramSocket socket = await RawDatagramSocket.bind(localAddress, 20499);

    Completer<String> completer = Completer<String>();
    socket.listen((event) {
      if (event == RawSocketEvent.read) {
        Datagram packet = socket.receive()!;
        if (packet != null) {
          if (packet.data[0] == 0 && packet.data[1] == 1) { // ARP response
            List<int> macBytes = packet.data.sublist(6, 12);
            String macAddress = macBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join(':');
            completer.complete(macAddress);
          }
        }
      }
    });

    List<int> requestPacket = [
      0, 1, // Hardware type (Ethernet)
      8, 0, // Protocol type (IPv4)
      6, // Hardware address length (MAC address)
      4, // Protocol address length (IPv4 address)
      0, 1, // Operation (ARP request)
      ...socket.address.rawAddress, // Sender hardware address
      ...targetAddress.rawAddress, // Target protocol address
      0, 0, 0, 0, 0, 0, // Target hardware address (unknown)
      ...targetAddress.rawAddress, // Target protocol address
    ];
    socket.send(requestPacket, targetAddress,20499);

    // Add a timeout to the completer
    Future.delayed(Duration(seconds: 5), () {
      if (!completer.isCompleted) {
        completer.completeError('Timeout');
      }
    });

    return completer.future.catchError((error) {
      print('Error: $error');
      return error;
    });
  }

  void addDevice(NetworkDevice device){
    _devicesList.add(device);
    update();
  }

  List<NetworkDevice> get getDevicesList{
    return _devicesList;
  }

  void scanNetwork()async{
    _devicesList.clear();
    var _result;
    int count = 0 ;

    ArpScanner.onScanning.listen((Device device) async{
        addDevice(NetworkDevice('Device (${++count})',device.ip!));
    });
    ArpScanner.onScanFinished.listen((List<Device> devices) {
        _result = "${_result}total: ${devices.length}";

    });
    ArpScanner.scan();
  }


}