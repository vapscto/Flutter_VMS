import 'dart:convert';
/// message : "success"
/// code : 100
/// data : {"attachmentUrl":["https://s3.ap-south-1.amazonaws.com/madhumedicals/profile/1657259197747_Capture1.PNG"],"responseCode":109}

UploadFilesModel uploadFilesModelFromJson(String str) => UploadFilesModel.fromJson(json.decode(str));
String uploadFilesModelToJson(UploadFilesModel data) => json.encode(data.toJson());
class UploadFilesModel {
  UploadFilesModel({
      String? message, 
      int? code, 
      Data? data,}){
    _message = message;
    _code = code;
    _data = data;
}

  UploadFilesModel.fromJson(dynamic json) {
    _message = json['message'];
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _message;
  int? _code;
  Data? _data;
UploadFilesModel copyWith({  String? message,
  int? code,
  Data? data,
}) => UploadFilesModel(  message: message ?? _message,
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

/// attachmentUrl : ["https://s3.ap-south-1.amazonaws.com/madhumedicals/profile/1657259197747_Capture1.PNG"]
/// responseCode : 109

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      List<String>? attachmentUrl, 
      int? responseCode,}){
    _attachmentUrl = attachmentUrl;
    _responseCode = responseCode;
}

  Data.fromJson(dynamic json) {
    _attachmentUrl = json['attachmentUrl'] != null ? json['attachmentUrl'].cast<String>() : [];
    _responseCode = json['responseCode'];
  }
  List<String>? _attachmentUrl;
  int? _responseCode;
Data copyWith({  List<String>? attachmentUrl,
  int? responseCode,
}) => Data(  attachmentUrl: attachmentUrl ?? _attachmentUrl,
  responseCode: responseCode ?? _responseCode,
);
  List<String>? get attachmentUrl => _attachmentUrl;
  int? get responseCode => _responseCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attachmentUrl'] = _attachmentUrl;
    map['responseCode'] = _responseCode;
    return map;
  }

}