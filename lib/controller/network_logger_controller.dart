
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:network_logger/network_logger.dart';
import 'package:dio/dio.dart';

class NetworkLoggerController extends GetxController {
  final client = Dio();
  BuildContext context = Get.context!;
  NetworkLoggerController(BuildContext context){
    this.context = context;
  }
  @override
  void onInit() {
    super.onInit();
    client.interceptors.add(DioNetworkLogger());
  }
  void openLogger(){
    NetworkLoggerScreen.open(context);
  }

  void example1() {
    client.get('https://flutter.dev/');
  }

  void example2() {
    client.get('https://jsonplaceholder.typicode.com/todos');
  }

  void example3() {
    client.delete('https://google.com/some-resource');
  }

  void example4() {
    client.post(
      'https://run.mocky.io/v3/c80877c3-8d4a-477b-9c45-a1441c34a6b6',
      data: <String, dynamic>{
        'products': 5,
        'foo': 'bar',
        'hello': [
          'world',
          'dunya',
        ]
      },
    );
  }
}