class ManagerStudentModel {
  String? type;
  List<ManagerStudentModelValues>? values;

  ManagerStudentModel({this.type, this.values});

  ManagerStudentModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ManagerStudentModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ManagerStudentModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ManagerStudentModelValues {
  int? mIId;
  int? asmaYId;
  int? asmcLId;
  int? asmSId;
  int? amsTId;
  String? amsTFirstName;
  String? amsTMiddleName;
  String? amsTLastName;
  String? amsTAdmNo;
  String? amsTRegistrationNo;
  String? amsTDOB;
  String? amsTBloodGroup;
  int? amsTMobileNo;
  String? amsTEmailId;
  String? amsTPhotoname;
  String? amsTTpin;
  String? asmcLClassName;
  String? asmCSectionName;
  String? asmaYYear;
  int? amsTAadharNo;

  ManagerStudentModelValues(
      {this.mIId,
      this.asmaYId,
      this.asmcLId,
      this.asmSId,
      this.amsTId,
      this.amsTFirstName,
      this.amsTMiddleName,
      this.amsTLastName,
      this.amsTAdmNo,
      this.amsTRegistrationNo,
      this.amsTDOB,
      this.amsTBloodGroup,
      this.amsTMobileNo,
      this.amsTEmailId,
      this.amsTPhotoname,
      this.amsTTpin,
      this.asmcLClassName,
      this.asmCSectionName,
      this.asmaYYear,
      this.amsTAadharNo});

  ManagerStudentModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
    amsTId = json['amsT_Id'];
    amsTFirstName = json['amsT_FirstName'];
    amsTMiddleName = json['amsT_MiddleName'];
    amsTLastName = json['amsT_LastName'];
    amsTAdmNo = json['amsT_AdmNo'];
    amsTRegistrationNo = json['amsT_RegistrationNo'];
    amsTDOB = json['amsT_DOB'];
    amsTBloodGroup = json['amsT_BloodGroup'];
    amsTMobileNo = json['amsT_MobileNo'];
    amsTEmailId = json['amsT_emailId'];
    amsTPhotoname = json['amsT_Photoname'];
    amsTTpin = json['amsT_Tpin'];
    asmcLClassName = json['asmcL_ClassName'];
    asmCSectionName = json['asmC_SectionName'];
    asmaYYear = json['asmaY_Year'];
    amsTAadharNo = json['amsT_AadharNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['asmcL_Id'] = asmcLId;
    data['asmS_Id'] = asmSId;
    data['amsT_Id'] = amsTId;
    data['amsT_FirstName'] = amsTFirstName;
    data['amsT_MiddleName'] = amsTMiddleName;
    data['amsT_LastName'] = amsTLastName;
    data['amsT_AdmNo'] = amsTAdmNo;
    data['amsT_RegistrationNo'] = amsTRegistrationNo;
    data['amsT_DOB'] = amsTDOB;
    data['amsT_BloodGroup'] = amsTBloodGroup;
    data['amsT_MobileNo'] = amsTMobileNo;
    data['amsT_emailId'] = amsTEmailId;
    data['amsT_Photoname'] = amsTPhotoname;
    data['amsT_Tpin'] = amsTTpin;
    data['asmcL_ClassName'] = asmcLClassName;
    data['asmC_SectionName'] = asmCSectionName;
    data['asmaY_Year'] = asmaYYear;
    data['amsT_AadharNo'] = amsTAadharNo;
    return data;
  }
}
