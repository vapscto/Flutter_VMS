class RequestedDetailsPCModel {
  String? type;
  List<RequestedDetailsPCModelValues>? values;

  RequestedDetailsPCModel({this.type, this.values});

  RequestedDetailsPCModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <RequestedDetailsPCModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(RequestedDetailsPCModelValues.fromJson(v));
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

class RequestedDetailsPCModelValues {
  int? mIId;
  int? userid;
  int? roleid;
  int? hrmDId;
  int? pcreqtNId;
  int? hrmEId;
  int? pcreqtndeTId;
  int? pcmparTId;
  String? pcreqtNPurpose;
  String? pcreqtNDate;
  String? pcreqtNCreatedDate;
  int? pcreqtNCreatedBy;
  bool? returnval;
  bool? pcreqtndeTActiveFlg;
  bool? pcreqtNActiveFlg;
  String? departmentname;
  String? employeename;
  String? pcreqtNRequisitionNo;
  int? asmaYId;

  RequestedDetailsPCModelValues(
      {this.mIId,
      this.userid,
      this.roleid,
      this.hrmDId,
      this.pcreqtNId,
      this.hrmEId,
      this.pcreqtndeTId,
      this.pcmparTId,
      this.pcreqtNPurpose,
      this.pcreqtNDate,
      this.pcreqtNCreatedDate,
      this.pcreqtNCreatedBy,
      this.returnval,
      this.pcreqtndeTActiveFlg,
      this.pcreqtNActiveFlg,
      this.departmentname,
      this.employeename,
      this.pcreqtNRequisitionNo,
      this.asmaYId});

  RequestedDetailsPCModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    userid = json['userid'];
    roleid = json['roleid'];
    hrmDId = json['hrmD_Id'];
    pcreqtNId = json['pcreqtN_Id'];
    hrmEId = json['hrmE_Id'];
    pcreqtndeTId = json['pcreqtndeT_Id'];
    pcmparTId = json['pcmparT_Id'];
    pcreqtNPurpose = json['pcreqtN_Purpose'];
    pcreqtNDate = json['pcreqtN_Date'];
    pcreqtNCreatedDate = json['pcreqtN_CreatedDate'];
    pcreqtNCreatedBy = json['pcreqtN_CreatedBy'];
    returnval = json['returnval'];
    pcreqtndeTActiveFlg = json['pcreqtndeT_ActiveFlg'];
    pcreqtNActiveFlg = json['pcreqtN_ActiveFlg'];
    departmentname = json['departmentname'];
    employeename = json['employeename'];
    pcreqtNRequisitionNo = json['pcreqtN_RequisitionNo'];
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
    data['pcreqtN_Purpose'] = pcreqtNPurpose;
    data['pcreqtN_Date'] = pcreqtNDate;
    data['pcreqtN_CreatedDate'] = pcreqtNCreatedDate;
    data['pcreqtN_CreatedBy'] = pcreqtNCreatedBy;
    data['returnval'] = returnval;
    data['pcreqtndeT_ActiveFlg'] = pcreqtndeTActiveFlg;
    data['pcreqtN_ActiveFlg'] = pcreqtNActiveFlg;
    data['departmentname'] = departmentname;
    data['employeename'] = employeename;
    data['pcreqtN_RequisitionNo'] = pcreqtNRequisitionNo;
    data['asmaY_Id'] = asmaYId;
    return data;
  }
}
