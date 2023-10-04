class EmployeeListPcReqModel {
  String? type;
  List<EmployeeListPcReqModelValues>? values;

  EmployeeListPcReqModel({this.type, this.values});

  EmployeeListPcReqModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <EmployeeListPcReqModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new EmployeeListPcReqModelValues.fromJson(v));
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

class EmployeeListPcReqModelValues {
  int? mIId;
  int? userid;
  int? roleid;
  int? hrmDId;
  int? pcreqtNId;
  int? hrmEId;
  int? pcreqtndeTId;
  int? pcmparTId;
  String? empname;
  bool? returnval;
  bool? pcreqtndeTActiveFlg;
  bool? pcreqtNActiveFlg;
  int? asmaYId;

  EmployeeListPcReqModelValues(
      {this.mIId,
      this.userid,
      this.roleid,
      this.hrmDId,
      this.pcreqtNId,
      this.hrmEId,
      this.pcreqtndeTId,
      this.pcmparTId,
      this.empname,
      this.returnval,
      this.pcreqtndeTActiveFlg,
      this.pcreqtNActiveFlg,
      this.asmaYId});

  EmployeeListPcReqModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    userid = json['userid'];
    roleid = json['roleid'];
    hrmDId = json['hrmD_Id'];
    pcreqtNId = json['pcreqtN_Id'];
    hrmEId = json['hrmE_Id'];
    pcreqtndeTId = json['pcreqtndeT_Id'];
    pcmparTId = json['pcmparT_Id'];
    empname = json['empname'];
    returnval = json['returnval'];
    pcreqtndeTActiveFlg = json['pcreqtndeT_ActiveFlg'];
    pcreqtNActiveFlg = json['pcreqtN_ActiveFlg'];
    asmaYId = json['asmaY_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mI_Id'] = this.mIId;
    data['userid'] = this.userid;
    data['roleid'] = this.roleid;
    data['hrmD_Id'] = this.hrmDId;
    data['pcreqtN_Id'] = this.pcreqtNId;
    data['hrmE_Id'] = this.hrmEId;
    data['pcreqtndeT_Id'] = this.pcreqtndeTId;
    data['pcmparT_Id'] = this.pcmparTId;
    data['empname'] = this.empname;
    data['returnval'] = this.returnval;
    data['pcreqtndeT_ActiveFlg'] = this.pcreqtndeTActiveFlg;
    data['pcreqtN_ActiveFlg'] = this.pcreqtNActiveFlg;
    data['asmaY_Id'] = this.asmaYId;
    return data;
  }
}
