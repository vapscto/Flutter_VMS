class DetailsFee {
  String? type;
  List<DetailsFeeValues>? values;

  DetailsFee({this.type, this.values});

  DetailsFee.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DetailsFeeValues>[];
      json['\$values'].forEach((v) {
        values!.add(  DetailsFeeValues.fromJson(v));
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

class DetailsFeeValues {
  int? mIId;
  int? asmaYId;
  int? classid;
  int? recptCount;
  int? asmSId;
  int? asmcLId;
  int? headid;
  int? sectionid;
  String? sectionname;
  int? groupid;
  int? studCount;
  double? ballance;
  double? recived;
  double? paid;
  double? concession;

  DetailsFeeValues(
      {this.mIId,
      this.asmaYId,
      this.classid,
      this.recptCount,
      this.asmSId,
      this.asmcLId,
      this.headid,
      this.sectionid,
      this.sectionname,
      this.groupid,
      this.studCount,
      this.ballance,
      this.recived,
      this.paid,
      this.concession});

  DetailsFeeValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    classid = json['classid'];
    recptCount = json['recpt_count'];
    asmSId = json['asmS_Id'];
    asmcLId = json['asmcL_Id'];
    headid = json['headid'];
    sectionid = json['sectionid'];
    sectionname = json['sectionname'];
    groupid = json['groupid'];
    studCount = json['stud_count'];
    ballance = json['ballance'];
    recived = json['recived'];
    paid = json['paid'];
    concession = json['concession'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mI_Id'] = this.mIId;
    data['asmaY_Id'] = this.asmaYId;
    data['classid'] = this.classid;
    data['recpt_count'] = this.recptCount;
    data['asmS_Id'] = this.asmSId;
    data['asmcL_Id'] = this.asmcLId;
    data['headid'] = this.headid;
    data['sectionid'] = this.sectionid;
    data['sectionname'] = this.sectionname;
    data['groupid'] = this.groupid;
    data['stud_count'] = this.studCount;
    data['ballance'] = this.ballance;
    data['recived'] = this.recived;
    data['paid'] = this.paid;
    data['concession'] = this.concession;
    return data;
  }
}
