class ManagerExamModel {
  String? type;
  List<ManagerExamModelValues>? values;

  ManagerExamModel({this.type, this.values});

  ManagerExamModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ManagerExamModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ManagerExamModelValues.fromJson(v));
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

class ManagerExamModelValues {
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
  String? amstDob;
  int? amayRollNo;
  int? rollno;
  int? amstMobile;
  String? studentdob;
  String? examName;
  double? totalmarks;
  double? obtainmarks;
  double? persentage;
  String? result;
  int? userId;
  int? studentCount;

  ManagerExamModelValues(
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
      this.amstDob,
      this.amayRollNo,
      this.rollno,
      this.amstMobile,
      this.studentdob,
      this.examName,
      this.totalmarks,
      this.obtainmarks,
      this.persentage,
      this.result,
      this.userId,
      this.studentCount});

  ManagerExamModelValues.fromJson(Map<String, dynamic> json) {
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
    amstDob = json['amst_dob'];
    amayRollNo = json['amay_RollNo'];
    rollno = json['rollno'];
    amstMobile = json['amst_mobile'];
    studentdob = json['studentdob'];
    examName = json['exam_name'];
    totalmarks = json['totalmarks'];
    obtainmarks = json['obtainmarks'];
    persentage = json['persentage'];
    result = json['result'];
    userId = json['user_id'];
    studentCount = json['studentCount'];
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
    data['amst_dob'] = amstDob;
    data['amay_RollNo'] = amayRollNo;
    data['rollno'] = rollno;
    data['amst_mobile'] = amstMobile;
    data['studentdob'] = studentdob;
    data['exam_name'] = examName;
    data['totalmarks'] = totalmarks;
    data['obtainmarks'] = obtainmarks;
    data['persentage'] = persentage;
    data['result'] = result;
    data['user_id'] = userId;
    data['studentCount'] = studentCount;
    return data;
  }
}
