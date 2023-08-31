class FeeReportmodel {
  String? type;
  List<FeeReportmodelValues>? values;

  FeeReportmodel({this.type, this.values});

  FeeReportmodel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <FeeReportmodelValues>[];
      json['\$values'].forEach((v) {
        values!.add(FeeReportmodelValues.fromJson(v));
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

class FeeReportmodelValues {
  int? emEId;
  int? mIId;
  int? asmaYId;
  int? totalsms;
  int? totalEmail;
  int? castid;
  num?  balance;
  num? paid;
   num?  receivable;
   num?  concession;
  int? asmSId;
  String? section;
  int? classid;
  int? asmcLId;
  String? name;
  String? admno;
  String? regno;
  String? mobile;
  String? className;
  int? studCount;

  FeeReportmodelValues(
      {this.emEId,
      this.mIId,
      this.asmaYId,
      this.totalsms,
      this.totalEmail,
      this.castid,
      this.balance,
      this.paid,
      this.receivable,
      this.concession,
      this.asmSId,
      this.section,
      this.classid,
      this.asmcLId,
      this.name,
      this.admno,
      this.regno,
      this.mobile,
      this.className,
      this.studCount});

  FeeReportmodelValues.fromJson(Map<String, dynamic> json) {
    emEId = json['emE_Id'];
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    totalsms = json['totalsms'];
    totalEmail = json['totalEmail'];
    castid = json['castid'];
    balance = json['balance'];
    paid = json['paid'];
    receivable = json['receivable'];
    concession = json['concession'];
    asmSId = json['asmS_Id'];
    section = json['section'];
    classid = json['classid'];
    asmcLId = json['asmcL_Id'];
    name = json['name'];
    admno = json['admno'];
    regno = json['regno'];
    mobile = json['mobile'];
    className = json['class_Name'];
    studCount = json['stud_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emE_Id'] = this.emEId;
    data['mI_Id'] = this.mIId;
    data['asmaY_Id'] = this.asmaYId;
    data['totalsms'] = this.totalsms;
    data['totalEmail'] = this.totalEmail;
    data['castid'] = this.castid;
    data['balance'] = this.balance;
    data['paid'] = this.paid;
    data['receivable'] = this.receivable;
    data['concession'] = this.concession;
    data['asmS_Id'] = this.asmSId;
    data['section'] = this.section;
    data['classid'] = this.classid;
    data['asmcL_Id'] = this.asmcLId;
    data['name'] = this.name;
    data['admno'] = this.admno;
    data['regno'] = this.regno;
    data['mobile'] = this.mobile;
    data['class_Name'] = this.className;
    data['stud_count'] = this.studCount;
    return data;
  }
}
