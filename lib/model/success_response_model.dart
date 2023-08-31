/// message : "success"
/// code : 100
/// data : {"responseCode":109}

class SuccessResponseModel {
  SuccessResponseModel({
      String? message, 
      int? code, 
      Data? data,}){
    _message = message;
    _code = code;
    _data = data;
}

  SuccessResponseModel.fromJson(dynamic json) {
    _message = json['message'];
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _message;
  int? _code;
  Data? _data;
SuccessResponseModel copyWith({  String? message,
  int? code,
  Data? data,
}) => SuccessResponseModel(  message: message ?? _message,
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

/// responseCode : 109

class Data {
  Data({
      int? responseCode,}){
    _responseCode = responseCode;
}

  Data.fromJson(dynamic json) {
    _responseCode = json['responseCode'];
  }
  int? _responseCode;
Data copyWith({  int? responseCode,
}) => Data(  responseCode: responseCode ?? _responseCode,
);
  int? get responseCode => _responseCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['responseCode'] = _responseCode;
    return map;
  }

}