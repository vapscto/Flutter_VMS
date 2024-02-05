class EmployeeListPcReqModel {
  String? type;
  List<EmployeeListPcReqModelValues>? values;

  EmployeeListPcReqModel({this.type, this.values});

  EmployeeListPcReqModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <EmployeeListPcReqModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(EmployeeListPcReqModelValues.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['userid'] = userid;
    data['roleid'] = roleid;
    data['hrmD_Id'] = hrmDId;
    data['pcreqtN_Id'] = pcreqtNId;
    data['hrmE_Id'] = hrmEId;
    data['pcreqtndeT_Id'] = pcreqtndeTId;
    data['pcmparT_Id'] = pcmparTId;
    data['empname'] = empname;
    data['returnval'] = returnval;
    data['pcreqtndeT_ActiveFlg'] = pcreqtndeTActiveFlg;
    data['pcreqtN_ActiveFlg'] = pcreqtNActiveFlg;
    data['asmaY_Id'] = asmaYId;
    return data;
  }
}
