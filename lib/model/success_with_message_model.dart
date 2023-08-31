/// message : "success"
/// code : 100
/// data : {"message":"user account is logout successfully","responseCode":109}

class SuccessWithMessageModel {
  SuccessWithMessageModel({
    String? message,
    int? code,
    Data? data,
  }) {
    _message = message;
    _code = code;
    _data = data;
  }

  SuccessWithMessageModel.fromJson(dynamic json) {
    _message = json['message'];
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _message;
  int? _code;
  Data? _data;
  SuccessWithMessageModel copyWith({
    String? message,
    int? code,
    Data? data,
  }) =>
      SuccessWithMessageModel(
        message: message ?? _message,
        code: code ?? _code,
        data: data ?? _data,
      );
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

/// message : "user account is logout successfully"
/// responseCode : 109

class Data {
  Data({
    String? message,
    int? responseCode,
  }) {
    _message = message;
    _responseCode = responseCode;
  }

  Data.fromJson(dynamic json) {
    _message = json['message'];
    _responseCode = json['responseCode'];
  }
  String? _message;
  int? _responseCode;
  Data copyWith({
    String? message,
    int? responseCode,
  }) =>
      Data(
        message: message ?? _message,
        responseCode: responseCode ?? _responseCode,
      );
  String? get message => _message;
  int? get responseCode => _responseCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['responseCode'] = _responseCode;
    return map;
  }
}
