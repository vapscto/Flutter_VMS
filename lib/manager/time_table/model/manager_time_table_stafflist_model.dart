class ManagerTimeTableStaffList {
  String? type;
  List<ManagerTimeTableStaffListValues>? values;

  ManagerTimeTableStaffList({this.type, this.values});

  ManagerTimeTableStaffList.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <ManagerTimeTableStaffListValues>[];
      json['\$values'].forEach((v) {
        values!.add(new ManagerTimeTableStaffListValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ManagerTimeTableStaffListValues {
  int? mIId;
  int? hrmEId;
  int? asmaYId;
  int? periodCount;
  int? asmcLId;
  int? asmSId;
  bool? asmcLActiveFlag;
  int? dayCount;
  int? ttmDId;
  int? userid;
  int? amstId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? amstDob;
  int? amayRollNo;
  int? rollno;
  int? amstMobile;
  String? studentdob;

  ManagerTimeTableStaffListValues(
      {this.mIId,
      this.hrmEId,
      this.asmaYId,
      this.periodCount,
      this.asmcLId,
      this.asmSId,
      this.asmcLActiveFlag,
      this.dayCount,
      this.ttmDId,
      this.userid,
      this.amstId,
      this.firstName,
      this.middleName,
      this.lastName,
      this.amstDob,
      this.amayRollNo,
      this.rollno,
      this.amstMobile,
      this.studentdob});

  ManagerTimeTableStaffListValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    asmaYId = json['asmaY_Id'];
    periodCount = json['periodCount'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
    asmcLActiveFlag = json['asmcL_ActiveFlag'];
    dayCount = json['dayCount'];
    ttmDId = json['ttmD_Id'];
    userid = json['userid'];
    amstId = json['amst_Id'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    amstDob = json['amst_dob'];
    amayRollNo = json['amay_RollNo'];
    rollno = json['rollno'];
    amstMobile = json['amst_mobile'];
    studentdob = json['studentdob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mI_Id'] = this.mIId;
    data['hrmE_Id'] = this.hrmEId;
    data['asmaY_Id'] = this.asmaYId;
    data['periodCount'] = this.periodCount;
    data['asmcL_Id'] = this.asmcLId;
    data['asmS_Id'] = this.asmSId;
    data['asmcL_ActiveFlag'] = this.asmcLActiveFlag;
    data['dayCount'] = this.dayCount;
    data['ttmD_Id'] = this.ttmDId;
    data['userid'] = this.userid;
    data['amst_Id'] = this.amstId;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['amst_dob'] = this.amstDob;
    data['amay_RollNo'] = this.amayRollNo;
    data['rollno'] = this.rollno;
    data['amst_mobile'] = this.amstMobile;
    data['studentdob'] = this.studentdob;
    return data;
  }
}
