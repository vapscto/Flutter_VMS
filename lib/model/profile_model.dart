class ProfileDataModel {
  String? type;
  List<ProfileDataModelValues>? values;

  ProfileDataModel({this.type, this.values});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ProfileDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ProfileDataModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileDataModelValues {
  String? type;
  String? amsTFirstName;
  int? asmcLId;
  String? asmcLClassName;
  int? asmSId;
  String? asmCSectionName;
  int? asmaYId;
  String? asmaYYear;
  String? amsTAdmNo;
  String? amsTDOB;
  String? amsTEmailId;
  int? amsTMobileNo;
  String? amsTRegistrationNo;
  String? amsTPhotoname;
  String? aMSTTpin;
  String? deviceID;
  String? aMSTPerStreet;
  String? aMSTPerArea;
  String? aMSTPerCity;
  String? aMSTGPSTrackingId;
  int? aMSTId;
  int? dobflg;

  ProfileDataModelValues(
      {this.type,
      this.amsTFirstName,
      this.asmcLId,
      this.asmcLClassName,
      this.asmSId,
      this.asmCSectionName,
      this.asmaYId,
      this.asmaYYear,
      this.amsTAdmNo,
      this.amsTDOB,
      this.amsTEmailId,
      this.amsTMobileNo,
      this.amsTRegistrationNo,
      this.amsTPhotoname,
      this.aMSTTpin,
      this.deviceID,
      this.aMSTPerStreet,
      this.aMSTPerArea,
      this.aMSTPerCity,
      this.aMSTGPSTrackingId,
      this.aMSTId,
      this.dobflg});

  ProfileDataModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    amsTFirstName = json['amsT_FirstName'];
    asmcLId = json['asmcL_Id'];
    asmcLClassName = json['asmcL_ClassName'];
    asmSId = json['asmS_Id'];
    asmCSectionName = json['asmC_SectionName'];
    asmaYId = json['asmaY_Id'];
    asmaYYear = json['asmaY_Year'];
    amsTAdmNo = json['amsT_AdmNo'];
    amsTDOB = json['amsT_DOB'];
    amsTEmailId = json['amsT_emailId'];
    amsTMobileNo = json['amsT_MobileNo'];
    amsTRegistrationNo = json['amsT_RegistrationNo'];
    amsTPhotoname = json['amsT_Photoname'];
    aMSTTpin = json['AMST_Tpin'];
    deviceID = json['DeviceID'];
    aMSTPerStreet = json['AMST_PerStreet'];
    aMSTPerArea = json['AMST_PerArea'];
    aMSTPerCity = json['AMST_PerCity'];
    aMSTGPSTrackingId = json['AMST_GPSTrackingId'];
    aMSTId = json['AMST_Id'];
    dobflg = json['dobflg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['amsT_FirstName'] = amsTFirstName;
    data['asmcL_Id'] = asmcLId;
    data['asmcL_ClassName'] = asmcLClassName;
    data['asmS_Id'] = asmSId;
    data['asmC_SectionName'] = asmCSectionName;
    data['asmaY_Id'] = asmaYId;
    data['asmaY_Year'] = asmaYYear;
    data['amsT_AdmNo'] = amsTAdmNo;
    data['amsT_DOB'] = amsTDOB;
    data['amsT_emailId'] = amsTEmailId;
    data['amsT_MobileNo'] = amsTMobileNo;
    data['amsT_RegistrationNo'] = amsTRegistrationNo;
    data['amsT_Photoname'] = amsTPhotoname;
    data['AMST_Tpin'] = aMSTTpin;
    data['DeviceID'] = deviceID;
    data['AMST_PerStreet'] = aMSTPerStreet;
    data['AMST_PerArea'] = aMSTPerArea;
    data['AMST_PerCity'] = aMSTPerCity;
    data['AMST_GPSTrackingId'] = aMSTGPSTrackingId;
    data['AMST_Id'] = aMSTId;
    data['dobflg'] = dobflg;
    return data;
  }
}
