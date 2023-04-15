import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class SpeedTestController extends GetxController {
  final _speedTest = FlutterInternetSpeedTest();
  double _downSpeed = 0.0;
  String _downUnit = "Mbps";
  double _upSpeed = 0.0;
  String _upUnit = "Mbps";
  PublishSubject<double> eventObservable = PublishSubject();
  int start = 0;
  int end = 60;

  @override
  void onInit() {
    super.onInit();
  }

  void speed_test() {
    _speedTest.startTesting(
      useFastApi: true,
      onStarted: () {
        // TODO
      },
      onCompleted: (TestResult download, TestResult upload) {
        setDownSpeed(download);
        setUpSpeed(upload);
      },
      onProgress: (double percent, TestResult data) {
        eventObservable.add(data.transferRate);
        if (data.type == TestType.download)
          setDownSpeed(data);
        else
          setUpSpeed(data);
      },
      onDownloadComplete: (TestResult data) {
        Fluttertoast.showToast(msg: "Download Done !");
      },
      onUploadComplete: (TestResult data) {
        Fluttertoast.showToast(msg: "Upload Done !");
      },
      onCancel: () {
        // TODO Request cancelled callback
      },
    );
  }

  double get downSpeed => _downSpeed;

  void setDownSpeed(TestResult result) {
    _downSpeed = result.transferRate;
    _downUnit = speedUnitToString(result.unit);
    update();
  }
  String get downUnit => _downUnit;

  double get upSpeed => _upSpeed;

  void setUpSpeed(TestResult result) {
    _upSpeed = result.transferRate;
    _upUnit = speedUnitToString(result.unit);
    update();
  }

  String get upUnit => _upUnit;

  String speedUnitToString(SpeedUnit speedUnit){
    return speedUnit == SpeedUnit.mbps ? "Mbps" : "Kbps";
  }

}
