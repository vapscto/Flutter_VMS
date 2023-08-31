class FillFellDetailsModel {
  String? type;
  List<FillFellDetailsModelValues>? values;

  FillFellDetailsModel({this.type, this.values});

  FillFellDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <FillFellDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(FillFellDetailsModelValues.fromJson(v));
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

class FillFellDetailsModelValues {
  num? mIId;
  num? asmaYId;
  num? classid;
  num? asmSId;
  num? asmcLId;
  num? headid;
  num? sectionid;
  num? groupid;
  String? groupname;
  num? studCount;
  num? ballance;
  num? recived;
  num? paid;
  num? concession;

  FillFellDetailsModelValues(
      {this.mIId,
      this.asmaYId,
      this.classid,
      this.asmSId,
      this.asmcLId,
      this.headid,
      this.sectionid,
      this.groupid,
      this.groupname,
      this.studCount,
      this.ballance,
      this.recived,
      this.paid,
      this.concession});

  FillFellDetailsModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    classid = json['classid'];
    asmSId = json['asmS_Id'];
    asmcLId = json['asmcL_Id'];
    headid = json['headid'];
    sectionid = json['sectionid'];
    groupid = json['groupid'];
    groupname = json['groupname'];
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
    data['asmS_Id'] = this.asmSId;
    data['asmcL_Id'] = this.asmcLId;
    data['headid'] = this.headid;
    data['sectionid'] = this.sectionid;
    data['groupid'] = this.groupid;
    data['groupname'] = this.groupname;
    data['stud_count'] = this.studCount;
    data['ballance'] = this.ballance;
    data['recived'] = this.recived;
    data['paid'] = this.paid;
    data['concession'] = this.concession;
    return data;
  }
}
