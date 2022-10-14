import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:pentor/controller/HomePageController.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translator = AppLocalizations.of(context)!;

    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text(translator.homePageTitle),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(translator.homePageCounterText),
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
