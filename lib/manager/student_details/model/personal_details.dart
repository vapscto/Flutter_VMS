class PersonalDetails {
  String? type;
  List<PersonalDetailsValues>? values;

  PersonalDetails({this.type, this.values});

  PersonalDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PersonalDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(PersonalDetailsValues.fromJson(v));
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

class PersonalDetailsValues {
  int? mIId;
  int? hrmEId;
  int? asmaYId;
  int? emEId;
  int? periodCount;
  int? asmcLId;
  int? asmSId;
  bool? asmcLActiveFlag;
  int? dayCount;
  int? ttmDId;
  int? userid;
  int? amstId;
  String? amstFirstName;
  String? amstMiddleName;
  String? amstLastName;
  String? amstRegistrationNo;
  String? amstAdmNo;
  String? amstSex;
  String? amstDob;
  String? amstEmailid;
  int? amayRollNo;
  String? classname;
  String? sectionname;
  int? rollno;
  int? amstMobile;
  String? fathername;
  String? mothername;
  String? bloodgroup;
  String? address1;
  String? address2;
  String? address3;
  String? studentdob;
  int? fathermobileno;
  String? asmaYear;
  int? userId;
  int? studentCount;
  String? amsTFatherOccupation;
  String? amsTMotherOccupation;
  String? amsTPhotoName;

  PersonalDetailsValues(
      {this.mIId,
      this.hrmEId,
      this.asmaYId,
      this.emEId,
      this.periodCount,
      this.asmcLId,
      this.asmSId,
      this.asmcLActiveFlag,
      this.dayCount,
      this.ttmDId,
      this.userid,
      this.amstId,
      this.amstFirstName,
      this.amstMiddleName,
      this.amstLastName,
      this.amstRegistrationNo,
      this.amstAdmNo,
      this.amstSex,
      this.amstDob,
      this.amstEmailid,
      this.amayRollNo,
      this.classname,
      this.sectionname,
      this.rollno,
      this.amstMobile,
      this.fathername,
      this.mothername,
      this.bloodgroup,
      this.address1,
      this.address2,
      this.address3,
      this.studentdob,
      this.fathermobileno,
      this.asmaYear,
      this.userId,
      this.studentCount,
      this.amsTFatherOccupation,
      this.amsTMotherOccupation,
      this.amsTPhotoName});

  PersonalDetailsValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    asmaYId = json['asmaY_Id'];
    emEId = json['emE_Id'];
    periodCount = json['periodCount'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
    asmcLActiveFlag = json['asmcL_ActiveFlag'];
    dayCount = json['dayCount'];
    ttmDId = json['ttmD_Id'];
    userid = json['userid'];
    amstId = json['amst_Id'];
    amstFirstName = json['amst_FirstName'];
    amstMiddleName = json['amst_MiddleName'];
    amstLastName = json['amst_LastName'];
    amstRegistrationNo = json['amst_RegistrationNo'];
    amstAdmNo = json['amst_AdmNo'];
    amstSex = json['amst_sex'];
    amstDob = json['amst_dob'];
    amstEmailid = json['amst_emailid'];
    amayRollNo = json['amay_RollNo'];
    classname = json['classname'];
    sectionname = json['sectionname'];
    rollno = json['rollno'];
    amstMobile = json['amst_mobile'];
    fathername = json['fathername'];
    mothername = json['mothername'];
    bloodgroup = json['bloodgroup'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    studentdob = json['studentdob'];
    fathermobileno = json['fathermobileno'];
    asmaYear = json['asma_year'];
    userId = json['user_id'];
    studentCount = json['studentCount'];
    amsTFatherOccupation = json['amsT_FatherOccupation'];
    amsTMotherOccupation = json['amsT_MotherOccupation'];
    amsTPhotoName = json['amsT_Photoname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['hrmE_Id'] = hrmEId;
    data['asmaY_Id'] = asmaYId;
    data['emE_Id'] = emEId;
    data['periodCount'] = periodCount;
    data['asmcL_Id'] = asmcLId;
    data['asmS_Id'] = asmSId;
    data['asmcL_ActiveFlag'] = asmcLActiveFlag;
    data['dayCount'] = dayCount;
    data['ttmD_Id'] = ttmDId;
    data['userid'] = userid;
    data['amst_Id'] = amstId;
    data['amst_FirstName'] = amstFirstName;
    data['amst_MiddleName'] = amstMiddleName;
    data['amst_LastName'] = amstLastName;
    data['amst_RegistrationNo'] = amstRegistrationNo;
    data['amst_AdmNo'] = amstAdmNo;
    data['amst_sex'] = amstSex;
    data['amst_dob'] = amstDob;
    data['amst_emailid'] = amstEmailid;
    data['amay_RollNo'] = amayRollNo;
    data['classname'] = classname;
    data['sectionname'] = sectionname;
    data['rollno'] = rollno;
    data['amst_mobile'] = amstMobile;
    data['fathername'] = fathername;
    data['mothername'] = mothername;
    data['bloodgroup'] = bloodgroup;
    data['address1'] = address1;
    data['address2'] = address2;
    data['address3'] = address3;
    data['studentdob'] = studentdob;
    data['fathermobileno'] = fathermobileno;
    data['asma_year'] = asmaYear;
    data['user_id'] = userId;
    data['studentCount'] = studentCount;
    data['amsT_FatherOccupation'] = amsTFatherOccupation;
    data['amsT_MotherOccupation'] = amsTMotherOccupation;
    return data;
  }
}
