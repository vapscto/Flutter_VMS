class ClasssectionListmodel {
  String? type;
  List<ClasssectionValues>? values;

  ClasssectionListmodel({this.type, this.values});

  ClasssectionListmodel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ClasssectionValues>[];
      json['\$values'].forEach((v) {
        values!.add(new ClasssectionValues.fromJson(v));
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

class ClasssectionValues {
  int? emEId;
  int? mIId;
  int? asmaYId;
  int? totalsms;
  int? totalEmail;
  int? castid;
  int? balance;
  double? paid;
  double? receivable;
 double? concession;
  int? asmSId;
  int? classid;
  int? asmcLId;
  String? sectionname;
  int? studCount;

  ClasssectionValues(
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
      this.classid,
      this.asmcLId,
      this.sectionname,
      this.studCount});

  ClasssectionValues.fromJson(Map<String, dynamic> json) {
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
    classid = json['classid'];
    asmcLId = json['asmcL_Id'];
    sectionname = json['sectionname'];
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
    data['classid'] = this.classid;
    data['asmcL_Id'] = this.asmcLId;
    data['sectionname'] = this.sectionname;
    data['stud_count'] = this.studCount;
    return data;
  }
}
