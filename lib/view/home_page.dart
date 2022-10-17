import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/HomePageController.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text('HOME_PAGE_TITLE'.tr),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('HOME_PAGE_COUNTER'.tr),
                    Text(
                      '${controller.counter}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: controller.onClickAction,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ));
  }
}
