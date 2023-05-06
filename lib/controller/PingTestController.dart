import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PingTestController extends GetxController {
  final urlController = TextEditingController();
  final pingResults = <PingData>[].obs;
  var transmittedPackets = 0.obs;
  var lostPackets = 0.obs;

  void doPing() async {
    final url = urlController.text.trim();
    final ping = Ping(url, count: 5);
    final stream = ping.stream;

    pingResults.clear();
    transmittedPackets.value = 0;
    lostPackets.value = 0;

    stream.listen((event) {
      if (event.toString().startsWith("PingResponse")) {
        if (event.response?.time != null) {
          pingResults.add(event);
        } else {
          lostPackets.value++;
        }
        transmittedPackets.value++;
      }
    });
  }
}
