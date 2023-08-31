import 'dart:convert';
/// message : "success"
/// code : 100
/// data : {"responseCode":109,"user":{"_id":"62de4bf606c545bc9aa8a6b8","userName":"9483506963","userType":"user","profileImage":"","email":"narayanhegde14@gmail.com","mobileNo":"9483506963"},"notificationCount":0}

LoginVerificationModel loginVerificationModelFromJson(String str) => LoginVerificationModel.fromJson(json.decode(str));
String loginVerificationModelToJson(LoginVerificationModel data) => json.encode(data.toJson());
class LoginVerificationModel {
  LoginVerificationModel({
      this.message, 
      this.code, 
      this.data,});

  LoginVerificationModel.fromJson(dynamic json) {
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  int? code;
  Data? data;
LoginVerificationModel copyWith({  String? message,
  int? code,
  Data? data,
}) => LoginVerificationModel(  message: message ?? this.message,
  code: code ?? this.code,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['code'] = code;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// responseCode : 109
/// user : {"_id":"62de4bf606c545bc9aa8a6b8","userName":"9483506963","userType":"user","profileImage":"","email":"narayanhegde14@gmail.com","mobileNo":"9483506963"}
/// notificationCount : 0

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.responseCode, 
      this.user, 
      this.notificationCount,});

  Data.fromJson(dynamic json) {
    responseCode = json['responseCode'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    notificationCount = json['notificationCount'];
  }
  int? responseCode;
  User? user;
  int? notificationCount;
Data copyWith({  int? responseCode,
  User? user,
  int? notificationCount,
}) => Data(  responseCode: responseCode ?? this.responseCode,
  user: user ?? this.user,
  notificationCount: notificationCount ?? this.notificationCount,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['responseCode'] = responseCode;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['notificationCount'] = notificationCount;
    return map;
  }

}

/// _id : "62de4bf606c545bc9aa8a6b8"
/// userName : "9483506963"
/// userType : "user"
/// profileImage : ""
/// email : "narayanhegde14@gmail.com"
/// mobileNo : "9483506963"

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      this.id, 
      this.userName, 
      this.userType, 
      this.profileImage, 
      this.email, 
      this.mobileNo,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    userName = json['userName'];
    userType = json['userType'];
    profileImage = json['profileImage'];
    email = json['email'];
    mobileNo = json['mobileNo'];
  }
  String? id;
  String? userName;
  String? userType;
  String? profileImage;
  String? email;
  String? mobileNo;
User copyWith({  String? id,
  String? userName,
  String? userType,
  String? profileImage,
  String? email,
  String? mobileNo,
}) => User(  id: id ?? this.id,
  userName: userName ?? this.userName,
  userType: userType ?? this.userType,
  profileImage: profileImage ?? this.profileImage,
  email: email ?? this.email,
  mobileNo: mobileNo ?? this.mobileNo,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['userName'] = userName;
    map['userType'] = userType;
    map['profileImage'] = profileImage;
    map['email'] = email;
    map['mobileNo'] = mobileNo;
    return map;
  }

}