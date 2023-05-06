import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/PingTestController.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';
import 'package:pentor/themes.dart';

class PingTestPage extends StatelessWidget {
   PingTestPage({Key? key}) : super(key: key);
  final pingController = Get.put(PingTestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Ping Test".tr),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: pingController.urlController,
              decoration: InputDecoration(
                labelText: 'Hostname/IP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => pingController.doPing(),
              child: Text('Start Test '.tr),
            ),
            SizedBox(height: 20),
            Obx(() {
              final pingResults = pingController.pingResults;
              if (pingResults.length == 5) {
                final transmitted = pingController.transmittedPackets;
                final lost = pingController.lostPackets;
                final percentage = lost > 0 ? lost / transmitted.toInt() * 100 : 0;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Ping Summary".tr),
                      backgroundColor:Themes.backgroundColor ,
                      content: Text(
                        'Transmitted Packets'.tr+ ': $transmitted\n'+
                            'Lost Packets'.tr +
                            ': $lost \n'+
                            'Packets Percentage loss'.tr+
                            ': ${percentage.toStringAsFixed(2)}% '.tr,
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'.tr),

                        ),
                      ],
                    ),
                  );
                });
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: pingResults.length,
                  itemBuilder: (context, index) {
                    final result = pingResults[index];
                    return ListTile(
                      title: Text('Ping Result'.tr +' ${index + 1}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('IP'.tr +' : ${result.response?.ip}'),
                          Text('TTL'.tr+ ' : ${result.response?.ttl}'),
                          Text('Time'.tr +' : ${result.response?.time?.inMilliseconds ?? 'N/A'}' + ' ms'.tr),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
