import 'package:telephony/telephony.dart';

class MobileNetworkInfo{
  String _name,_networkType,_signalStrength;

  MobileNetworkInfo([this._name='',this._networkType='',this._signalStrength='']);
  static Future<MobileNetworkInfo> initMobileNetInfo ()async{
    Telephony telephony  = Telephony.instance;
    String name = await telephony.networkOperatorName ?? 'UNKNOWN'  ;
    String networkType = (await telephony.dataNetworkType).name  ;
    String signalStrength = (await telephony.signalStrengths).first.name ;
    return Future(() => MobileNetworkInfo(name,networkType,signalStrength));
  }

  String get name => _name;
  String get signalStrength => _signalStrength;
  String get networkType => _networkType;
}