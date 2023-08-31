class ManagerDailyClassSectionModel {
  String? type;
  List<ManagerDailyClassSectionModelValues>? values;

  ManagerDailyClassSectionModel({this.type, this.values});

  ManagerDailyClassSectionModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <ManagerDailyClassSectionModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new ManagerDailyClassSectionModelValues.fromJson(v));
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

class ManagerDailyClassSectionModelValues {
  int? mIId;
  int? hrmEId;
  int? asmaYId;
  int? periodCount;
  int? asmcLId;
  int? asmSId;
  String? asmcLClassName;
  String? asmCSectionName;
  bool? asmcLActiveFlag;
  String? period;
  int? dayCount;
  int? ttmDId;
  int? userid;
  int? amstId;
  String? amstDob;
  int? amayRollNo;
  int? rollno;
  int? amstMobile;
  String? studentdob;

  ManagerDailyClassSectionModelValues(
      {this.mIId,
      this.hrmEId,
      this.asmaYId,
      this.periodCount,
      this.asmcLId,
      this.asmSId,
      this.asmcLClassName,
      this.asmCSectionName,
      this.asmcLActiveFlag,
      this.period,
      this.dayCount,
      this.ttmDId,
      this.userid,
      this.amstId,
      this.amstDob,
      this.amayRollNo,
      this.rollno,
      this.amstMobile,
      this.studentdob});

  ManagerDailyClassSectionModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    asmaYId = json['asmaY_Id'];
    periodCount = json['periodCount'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
    asmcLClassName = json['asmcL_ClassName'];
    asmCSectionName = json['asmC_SectionName'];
    asmcLActiveFlag = json['asmcL_ActiveFlag'];
    period = json['period'];
    dayCount = json['dayCount'];
    ttmDId = json['ttmD_Id'];
    userid = json['userid'];
    amstId = json['amst_Id'];
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
    data['asmcL_ClassName'] = this.asmcLClassName;
    data['asmC_SectionName'] = this.asmCSectionName;
    data['asmcL_ActiveFlag'] = this.asmcLActiveFlag;
    data['period'] = this.period;
    data['dayCount'] = this.dayCount;
    data['ttmD_Id'] = this.ttmDId;
    data['userid'] = this.userid;
    data['amst_Id'] = this.amstId;
    data['amst_dob'] = this.amstDob;
    data['amay_RollNo'] = this.amayRollNo;
    data['rollno'] = this.rollno;
    data['amst_mobile'] = this.amstMobile;
    data['studentdob'] = this.studentdob;
    return data;
  }
}
