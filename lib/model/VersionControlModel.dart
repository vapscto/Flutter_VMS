/// message : "success"
/// code : 100
/// data : {"setting":{"_id":"5fbb607a36dc1c7b852db323","version":[{"active":true,"forceUpdate":false,"name":"android","version":"1.0.2+3","redirectUrl":"https://google.com","createdAt":7387482374},{"active":true,"forceUpdate":false,"name":"ios","version":"1.0.2+3","redirectUrl":"https://google.com","createdAt":7387482374}],"centerRadius":5000},"responseCode":109}

class VersionControlModel {
  VersionControlModel({
      String? message, 
      int? code, 
      Data? data,}){
    _message = message;
    _code = code;
    _data = data;
}

  VersionControlModel.fromJson(dynamic json) {
    _message = json['message'];
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _message;
  int? _code;
  Data? _data;

  String? get message => _message;
  int? get code => _code;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['code'] = _code;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// setting : {"_id":"5fbb607a36dc1c7b852db323","version":[{"active":true,"forceUpdate":false,"name":"android","version":"1.0.2+3","redirectUrl":"https://google.com","createdAt":7387482374},{"active":true,"forceUpdate":false,"name":"ios","version":"1.0.2+3","redirectUrl":"https://google.com","createdAt":7387482374}],"centerRadius":5000}
/// responseCode : 109

class Data {
  Data({
      Setting? setting, 
      int? responseCode,}){
    _setting = setting;
    _responseCode = responseCode;
}

  Data.fromJson(dynamic json) {
    _setting = json['setting'] != null ? Setting.fromJson(json['setting']) : null;
    _responseCode = json['responseCode'];
  }
  Setting? _setting;
  int? _responseCode;

  Setting? get setting => _setting;
  int? get responseCode => _responseCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_setting != null) {
      map['setting'] = _setting?.toJson();
    }
    map['responseCode'] = _responseCode;
    return map;
  }

}

/// _id : "5fbb607a36dc1c7b852db323"
/// version : [{"active":true,"forceUpdate":false,"name":"android","version":"1.0.2+3","redirectUrl":"https://google.com","createdAt":7387482374},{"active":true,"forceUpdate":false,"name":"ios","version":"1.0.2+3","redirectUrl":"https://google.com","createdAt":7387482374}]
/// centerRadius : 5000

class Setting {
  Setting({
      String? id, 
      List<Version>? version, 
      int? centerRadius,}){
    _id = id;
    _version = version;
    _centerRadius = centerRadius;
}

  Setting.fromJson(dynamic json) {
    _id = json['_id'];
    if (json['version'] != null) {
      _version = [];
      json['version'].forEach((v) {
        _version?.add(Version.fromJson(v));
      });
    }
    _centerRadius = json['centerRadius'];
  }
  String? _id;
  List<Version>? _version;
  int? _centerRadius;

  String? get id => _id;
  List<Version>? get version => _version;
  int? get centerRadius => _centerRadius;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_version != null) {
      map['version'] = _version?.map((v) => v.toJson()).toList();
    }
    map['centerRadius'] = _centerRadius;
    return map;
  }

}

/// active : true
/// forceUpdate : false
/// name : "android"
/// version : "1.0.2+3"
/// redirectUrl : "https://google.com"
/// createdAt : 7387482374

class Version {
  Version({
      bool? active, 
      bool? forceUpdate, 
      String? name, 
      String? version, 
      String? redirectUrl, 
      int? createdAt,}){
    _active = active;
    _forceUpdate = forceUpdate;
    _name = name;
    _version = version;
    _redirectUrl = redirectUrl;
    _createdAt = createdAt;
}

  Version.fromJson(dynamic json) {
    _active = json['active'];
    _forceUpdate = json['forceUpdate'];
    _name = json['name'];
    _version = json['version'];
    _redirectUrl = json['redirectUrl'];
    _createdAt = json['createdAt'];
  }
  bool? _active;
  bool? _forceUpdate;
  String? _name;
  String? _version;
  String? _redirectUrl;
  int? _createdAt;

  bool? get active => _active;
  bool? get forceUpdate => _forceUpdate;
  String? get name => _name;
  String? get version => _version;
  String? get redirectUrl => _redirectUrl;
  int? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['active'] = _active;
    map['forceUpdate'] = _forceUpdate;
    map['name'] = _name;
    map['version'] = _version;
    map['redirectUrl'] = _redirectUrl;
    map['createdAt'] = _createdAt;
    return map;
  }

}