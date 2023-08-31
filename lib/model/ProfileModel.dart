import 'dart:convert';
/// message : "success"
/// code : 100
/// data : {"profile":{"paymentProof":{"description":"","path":""},"_id":"62de4bf606c545bc9aa8a6b8","active":true,"userName":"9483506963","userType":"user","remark":"","isSuperAdmin":false,"isSuperEmployer":false,"passwordAttempt":0,"passwordReset":false,"otpValidationCount":0,"loginValidationCount":0,"loginValidationTime":0,"otpValidationTime":0,"fname":"Narayan","lname":"Hegde","about":"","skills":[],"gender":"","gallery":[],"videos":[],"website":"","emailVerified":true,"status":"pending","profileImage":"","socketId":"","email":"narayanhegde14@gmail.com","mobileNo":"9483506963","online":false,"deliveryAddress":[],"preferedLanuage":[],"paymentDone":false,"paymentMode":"","paymentRefId":"","payment":0,"receivedPayment":0,"invoiceId":"","coupon":"","discount":0,"socialLink":[],"experience":[],"updatedAt":1658735606,"createdAt":1658735606,"__v":0,"lastLogin":1658740148},"message":"User profile info","responseCode":109}

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));
String profileModelToJson(ProfileModel data) => json.encode(data.toJson());
class ProfileModel {
  ProfileModel({
      this.message, 
      this.code, 
      this.data,});

  ProfileModel.fromJson(dynamic json) {
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  int? code;
  Data? data;
ProfileModel copyWith({  String? message,
  int? code,
  Data? data,
}) => ProfileModel(  message: message ?? this.message,
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

/// profile : {"paymentProof":{"description":"","path":""},"_id":"62de4bf606c545bc9aa8a6b8","active":true,"userName":"9483506963","userType":"user","remark":"","isSuperAdmin":false,"isSuperEmployer":false,"passwordAttempt":0,"passwordReset":false,"otpValidationCount":0,"loginValidationCount":0,"loginValidationTime":0,"otpValidationTime":0,"fname":"Narayan","lname":"Hegde","about":"","skills":[],"gender":"","gallery":[],"videos":[],"website":"","emailVerified":true,"status":"pending","profileImage":"","socketId":"","email":"narayanhegde14@gmail.com","mobileNo":"9483506963","online":false,"deliveryAddress":[],"preferedLanuage":[],"paymentDone":false,"paymentMode":"","paymentRefId":"","payment":0,"receivedPayment":0,"invoiceId":"","coupon":"","discount":0,"socialLink":[],"experience":[],"updatedAt":1658735606,"createdAt":1658735606,"__v":0,"lastLogin":1658740148}
/// message : "User profile info"
/// responseCode : 109

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.profile, 
      this.message, 
      this.responseCode,});

  Data.fromJson(dynamic json) {
    profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    message = json['message'];
    responseCode = json['responseCode'];
  }
  Profile? profile;
  String? message;
  int? responseCode;
Data copyWith({  Profile? profile,
  String? message,
  int? responseCode,
}) => Data(  profile: profile ?? this.profile,
  message: message ?? this.message,
  responseCode: responseCode ?? this.responseCode,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (profile != null) {
      map['profile'] = profile?.toJson();
    }
    map['message'] = message;
    map['responseCode'] = responseCode;
    return map;
  }

}

/// paymentProof : {"description":"","path":""}
/// _id : "62de4bf606c545bc9aa8a6b8"
/// active : true
/// userName : "9483506963"
/// userType : "user"
/// remark : ""
/// isSuperAdmin : false
/// isSuperEmployer : false
/// passwordAttempt : 0
/// passwordReset : false
/// otpValidationCount : 0
/// loginValidationCount : 0
/// loginValidationTime : 0
/// otpValidationTime : 0
/// fname : "Narayan"
/// lname : "Hegde"
/// about : ""
/// skills : []
/// gender : ""
/// gallery : []
/// videos : []
/// website : ""
/// emailVerified : true
/// status : "pending"
/// profileImage : ""
/// socketId : ""
/// email : "narayanhegde14@gmail.com"
/// mobileNo : "9483506963"
/// online : false
/// deliveryAddress : []
/// preferedLanuage : []
/// paymentDone : false
/// paymentMode : ""
/// paymentRefId : ""
/// payment : 0
/// receivedPayment : 0
/// invoiceId : ""
/// coupon : ""
/// discount : 0
/// socialLink : []
/// experience : []
/// updatedAt : 1658735606
/// createdAt : 1658735606
/// __v : 0
/// lastLogin : 1658740148

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));
String profileToJson(Profile data) => json.encode(data.toJson());
class Profile {
  Profile({
      this.paymentProof, 
      this.id, 
      this.active, 
      this.userName, 
      this.userType, 
      this.remark, 
      this.isSuperAdmin, 
      this.isSuperEmployer, 
      this.passwordAttempt, 
      this.passwordReset, 
      this.otpValidationCount, 
      this.loginValidationCount, 
      this.loginValidationTime, 
      this.otpValidationTime, 
      this.fname, 
      this.lname, 
      this.about, 
      this.skills, 
      this.gender, 
      this.gallery, 
      this.videos, 
      this.website, 
      this.emailVerified, 
      this.status, 
      this.profileImage, 
      this.socketId, 
      this.email, 
      this.mobileNo, 
      this.online, 
      this.deliveryAddress, 
      this.preferedLanuage, 
      this.paymentDone, 
      this.paymentMode, 
      this.paymentRefId, 
      this.payment, 
      this.receivedPayment, 
      this.invoiceId, 
      this.coupon, 
      this.discount, 
      this.socialLink, 
      this.experience, 
      this.updatedAt, 
      this.createdAt, 
      this.v, 
      this.lastLogin,});

  Profile.fromJson(dynamic json) {
    paymentProof = json['paymentProof'] != null ? PaymentProof.fromJson(json['paymentProof']) : null;
    id = json['_id'];
    active = json['active'];
    userName = json['userName'];
    userType = json['userType'];
    remark = json['remark'];
    isSuperAdmin = json['isSuperAdmin'];
    isSuperEmployer = json['isSuperEmployer'];
    passwordAttempt = json['passwordAttempt'];
    passwordReset = json['passwordReset'];
    otpValidationCount = json['otpValidationCount'];
    loginValidationCount = json['loginValidationCount'];
    loginValidationTime = json['loginValidationTime'];
    otpValidationTime = json['otpValidationTime'];
    fname = json['fname'];
    lname = json['lname'];
    about = json['about'];
    if (json['skills'] != null) {
      skills = [];
      json['skills'].forEach((v) {
        skills?.add(v.fromJson(v));
      });
    }
    gender = json['gender'];
    if (json['gallery'] != null) {
      gallery = [];
      json['gallery'].forEach((v) {
        gallery?.add(v.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos?.add(v.fromJson(v));
      });
    }
    website = json['website'];
    emailVerified = json['emailVerified'];
    status = json['status'];
    profileImage = json['profileImage'];
    socketId = json['socketId'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    online = json['online'];
    if (json['deliveryAddress'] != null) {
      deliveryAddress = [];
      json['deliveryAddress'].forEach((v) {
        deliveryAddress?.add(v.fromJson(v));
      });
    }
    if (json['preferedLanuage'] != null) {
      preferedLanuage = [];
      json['preferedLanuage'].forEach((v) {
        preferedLanuage?.add(v.fromJson(v));
      });
    }
    paymentDone = json['paymentDone'];
    paymentMode = json['paymentMode'];
    paymentRefId = json['paymentRefId'];
    payment = json['payment'];
    receivedPayment = json['receivedPayment'];
    invoiceId = json['invoiceId'];
    coupon = json['coupon'];
    discount = json['discount'];
    if (json['socialLink'] != null) {
      socialLink = [];
      json['socialLink'].forEach((v) {
        socialLink?.add(v.fromJson(v));
      });
    }
    if (json['experience'] != null) {
      experience = [];
      json['experience'].forEach((v) {
        experience?.add(v.fromJson(v));
      });
    }
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    v = json['__v'];
    lastLogin = json['lastLogin'];
  }
  PaymentProof? paymentProof;
  String? id;
  bool? active;
  String? userName;
  String? userType;
  String? remark;
  bool? isSuperAdmin;
  bool? isSuperEmployer;
  int? passwordAttempt;
  bool? passwordReset;
  int? otpValidationCount;
  int? loginValidationCount;
  int? loginValidationTime;
  int? otpValidationTime;
  String? fname;
  String? lname;
  String? about;
  List<dynamic>? skills;
  String? gender;
  List<dynamic>? gallery;
  List<dynamic>? videos;
  String? website;
  bool? emailVerified;
  String? status;
  String? profileImage;
  String? socketId;
  String? email;
  String? mobileNo;
  bool? online;
  List<dynamic>? deliveryAddress;
  List<dynamic>? preferedLanuage;
  bool? paymentDone;
  String? paymentMode;
  String? paymentRefId;
  int? payment;
  int? receivedPayment;
  String? invoiceId;
  String? coupon;
  int? discount;
  List<dynamic>? socialLink;
  List<dynamic>? experience;
  int? updatedAt;
  int? createdAt;
  int? v;
  int? lastLogin;
Profile copyWith({  PaymentProof? paymentProof,
  String? id,
  bool? active,
  String? userName,
  String? userType,
  String? remark,
  bool? isSuperAdmin,
  bool? isSuperEmployer,
  int? passwordAttempt,
  bool? passwordReset,
  int? otpValidationCount,
  int? loginValidationCount,
  int? loginValidationTime,
  int? otpValidationTime,
  String? fname,
  String? lname,
  String? about,
  List<dynamic>? skills,
  String? gender,
  List<dynamic>? gallery,
  List<dynamic>? videos,
  String? website,
  bool? emailVerified,
  String? status,
  String? profileImage,
  String? socketId,
  String? email,
  String? mobileNo,
  bool? online,
  List<dynamic>? deliveryAddress,
  List<dynamic>? preferedLanuage,
  bool? paymentDone,
  String? paymentMode,
  String? paymentRefId,
  int? payment,
  int? receivedPayment,
  String? invoiceId,
  String? coupon,
  int? discount,
  List<dynamic>? socialLink,
  List<dynamic>? experience,
  int? updatedAt,
  int? createdAt,
  int? v,
  int? lastLogin,
}) => Profile(  paymentProof: paymentProof ?? this.paymentProof,
  id: id ?? this.id,
  active: active ?? this.active,
  userName: userName ?? this.userName,
  userType: userType ?? this.userType,
  remark: remark ?? this.remark,
  isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
  isSuperEmployer: isSuperEmployer ?? this.isSuperEmployer,
  passwordAttempt: passwordAttempt ?? this.passwordAttempt,
  passwordReset: passwordReset ?? this.passwordReset,
  otpValidationCount: otpValidationCount ?? this.otpValidationCount,
  loginValidationCount: loginValidationCount ?? this.loginValidationCount,
  loginValidationTime: loginValidationTime ?? this.loginValidationTime,
  otpValidationTime: otpValidationTime ?? this.otpValidationTime,
  fname: fname ?? this.fname,
  lname: lname ?? this.lname,
  about: about ?? this.about,
  skills: skills ?? this.skills,
  gender: gender ?? this.gender,
  gallery: gallery ?? this.gallery,
  videos: videos ?? this.videos,
  website: website ?? this.website,
  emailVerified: emailVerified ?? this.emailVerified,
  status: status ?? this.status,
  profileImage: profileImage ?? this.profileImage,
  socketId: socketId ?? this.socketId,
  email: email ?? this.email,
  mobileNo: mobileNo ?? this.mobileNo,
  online: online ?? this.online,
  deliveryAddress: deliveryAddress ?? this.deliveryAddress,
  preferedLanuage: preferedLanuage ?? this.preferedLanuage,
  paymentDone: paymentDone ?? this.paymentDone,
  paymentMode: paymentMode ?? this.paymentMode,
  paymentRefId: paymentRefId ?? this.paymentRefId,
  payment: payment ?? this.payment,
  receivedPayment: receivedPayment ?? this.receivedPayment,
  invoiceId: invoiceId ?? this.invoiceId,
  coupon: coupon ?? this.coupon,
  discount: discount ?? this.discount,
  socialLink: socialLink ?? this.socialLink,
  experience: experience ?? this.experience,
  updatedAt: updatedAt ?? this.updatedAt,
  createdAt: createdAt ?? this.createdAt,
  v: v ?? this.v,
  lastLogin: lastLogin ?? this.lastLogin,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (paymentProof != null) {
      map['paymentProof'] = paymentProof?.toJson();
    }
    map['_id'] = id;
    map['active'] = active;
    map['userName'] = userName;
    map['userType'] = userType;
    map['remark'] = remark;
    map['isSuperAdmin'] = isSuperAdmin;
    map['isSuperEmployer'] = isSuperEmployer;
    map['passwordAttempt'] = passwordAttempt;
    map['passwordReset'] = passwordReset;
    map['otpValidationCount'] = otpValidationCount;
    map['loginValidationCount'] = loginValidationCount;
    map['loginValidationTime'] = loginValidationTime;
    map['otpValidationTime'] = otpValidationTime;
    map['fname'] = fname;
    map['lname'] = lname;
    map['about'] = about;
    if (skills != null) {
      map['skills'] = skills?.map((v) => v.toJson()).toList();
    }
    map['gender'] = gender;
    if (gallery != null) {
      map['gallery'] = gallery?.map((v) => v.toJson()).toList();
    }
    if (videos != null) {
      map['videos'] = videos?.map((v) => v.toJson()).toList();
    }
    map['website'] = website;
    map['emailVerified'] = emailVerified;
    map['status'] = status;
    map['profileImage'] = profileImage;
    map['socketId'] = socketId;
    map['email'] = email;
    map['mobileNo'] = mobileNo;
    map['online'] = online;
    if (deliveryAddress != null) {
      map['deliveryAddress'] = deliveryAddress?.map((v) => v.toJson()).toList();
    }
    if (preferedLanuage != null) {
      map['preferedLanuage'] = preferedLanuage?.map((v) => v.toJson()).toList();
    }
    map['paymentDone'] = paymentDone;
    map['paymentMode'] = paymentMode;
    map['paymentRefId'] = paymentRefId;
    map['payment'] = payment;
    map['receivedPayment'] = receivedPayment;
    map['invoiceId'] = invoiceId;
    map['coupon'] = coupon;
    map['discount'] = discount;
    if (socialLink != null) {
      map['socialLink'] = socialLink?.map((v) => v.toJson()).toList();
    }
    if (experience != null) {
      map['experience'] = experience?.map((v) => v.toJson()).toList();
    }
    map['updatedAt'] = updatedAt;
    map['createdAt'] = createdAt;
    map['__v'] = v;
    map['lastLogin'] = lastLogin;
    return map;
  }

}

/// description : ""
/// path : ""

PaymentProof paymentProofFromJson(String str) => PaymentProof.fromJson(json.decode(str));
String paymentProofToJson(PaymentProof data) => json.encode(data.toJson());
class PaymentProof {
  PaymentProof({
      this.description, 
      this.path,});

  PaymentProof.fromJson(dynamic json) {
    description = json['description'];
    path = json['path'];
  }
  String? description;
  String? path;
PaymentProof copyWith({  String? description,
  String? path,
}) => PaymentProof(  description: description ?? this.description,
  path: path ?? this.path,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = description;
    map['path'] = path;
    return map;
  }

}