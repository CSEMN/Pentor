
class NetworkDevice{
  String _name,_ip;
  DeviceType _type;
  NetworkDevice([this._name='',this._ip='',this._type=DeviceType.None]);

  DeviceType get type => _type;

  get ip => _ip;

  String get name => _name;
}

enum DeviceType{
  None,
  Mobile,
  Computer,
  Printer,
  Other
}