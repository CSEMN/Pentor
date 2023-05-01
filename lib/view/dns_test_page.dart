import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/DnsTestController.dart';
import 'package:pentor/view/widgets/NavigationDrawer.dart';
import 'package:pentor/controller/NavigationDrawer_Controller.dart';
import 'package:pentor/themes.dart';

class DnsTestPage extends StatelessWidget {
  DnsTestPage({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    final controller = Get.put(DnsTestController());

    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("DNS Test".tr),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: controller.textEditingController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Hostname',
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(0.0),
                            ),
                            borderSide: new BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: controller.checkDns),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: Obx(() => SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.googleDnsResultList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                text: controller.googleDnsResultList[index],
                              ));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("IP Copied to clipboard".tr)),
                              );
                            },
                            child: ListTile(
                              tileColor: Themes.primaryColor,
                              leading: index == 0 ? Icon(Icons.dns) : SizedBox(width: 24.0),
                              title: index == 0
                                  ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "DNS Test Results".tr+"\n\n",
                                    style: textStyle,
                                  ),
                                ],
                              )
                                  : SizedBox.shrink(),
                              subtitle: index >= 0
                                  ? Padding(
                                padding: EdgeInsets.only(bottom: 18.0),
                                child: Text(
                                  controller.googleDnsResultList[index],
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )
                                  : null,
                            ),
                          );
                        },
                      ),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   itemCount: controller.cloudflareDnsResultList.length,
                      //   itemBuilder: (context, index) {
                      //     return ListTile(
                      //       tileColor: Themes.primaryColor,
                      //       leading: index == 0
                      //           ? Icon(Icons.flag_circle_sharp)
                      //           : SizedBox(
                      //         width: 24.0,
                      //       ),
                      //       title: index == 0
                      //           ? Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             "San Francisco CA, United States\ncloudflare\n\n",                                  style: textStyle,
                      //           ),
                      //         ],
                      //       )
                      //           : SizedBox.shrink(),
                      //       subtitle: index >= 0
                      //           ? Padding(
                      //         padding: EdgeInsets.only(bottom: 18.0),
                      //         child: Text(
                      //           controller.cloudflareDnsResultList[index],
                      //           style: TextStyle(color: Colors.blue),
                      //         ),
                      //       )
                      //           : null,
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
