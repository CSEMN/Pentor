
import 'dart:math';

class NetworkDevice{
  String _name,_ip,_mac;
  DeviceType _type;
  NetworkDevice([this._name='',this._ip='',this._type=DeviceType.None,this._mac=""]){
    this._mac = this._mac.isEmpty ? _generateMac(): this._mac;
    if(type == DeviceType.None){
      //rand type
      int index = Random().nextInt(DeviceType.values.length);
      _type = DeviceType.values[index];
      switch(type){
        case DeviceType.None:
          _name = "Unknown Device";
          break;
        case DeviceType.Mobile:
          _name = "Android phone";
          break;
        case DeviceType.Computer:
          _name = "Computer";
          break;
        case DeviceType.Printer:
          _name = "Printer";
          break;
        case DeviceType.Router:
          _name = "Gateway";
          break;
        case DeviceType.Other:
          _name = "Unknown Device";
          break;
      }
    }
  }

  DeviceType get type => _type;

  get ip => _ip;

  String get name => _name;
  String get mac => _mac;

  String _generateMac() {
    Random r = Random();
    return List.generate(6, (_) => r.nextInt(256).toRadixString(16).padLeft(2, '0')).join(":");
  }

}

enum DeviceType{
  None,
  Mobile,
  Computer,
  Printer,
  Router,
  Other
}

