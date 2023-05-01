import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dns_client/dns_client.dart';

class DnsTestController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();
  final RxList<String> googleDnsResultList = <String>[].obs;
  // final RxList<String> cloudflareDnsResultList = <String>[].obs;

  Future<void> checkDns() async {
    final googleDns = DnsOverHttps.google();
    // final cloudflareDns = DnsOverHttps.cloudflare();

    final queryGoogle = await googleDns.lookup(textEditingController.text.trim());
    googleDnsResultList.value = queryGoogle.map((record) => record.address).toList();

    // final queryCloudflare = await cloudflareDns.lookup(textEditingController.text.trim());
    // cloudflareDnsResultList.value = queryCloudflare.map((record) => record.address).toList();
  }
}
