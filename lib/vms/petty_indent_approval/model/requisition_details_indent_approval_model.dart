class RequestIndentDetailsModel {
  String? type;
  List<RequestIndentDetailsModelValues>? values;

  RequestIndentDetailsModel({this.type, this.values});

  RequestIndentDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <RequestIndentDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new RequestIndentDetailsModelValues.fromJson(v));
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

class RequestIndentDetailsModelValues {
  int? pcindenTId;
  int? mIId;
  int? hrmEId;
  int? userid;
  int? asmaYId;
  int? roleid;
  int? pcreqtNId;
  int? pcreqtndeTId;
  int? pcindentaPId;
  int? pcmparTId;
  int? pcindentdeTId;
  String? pcreqtNDate;
  String? pcreqtNPurpose;
  String? departmentname;
  String? pcreqtNRequisitionNo;
  String? employeename;
  double? pcreqtNTotAmount;
  bool? returnval;
  bool? pcindenTActiveFlg;
  bool? pcreqtndeTActiveFlg;
  bool? pcindentdeTActiveFlg;
  String? createdate;

  RequestIndentDetailsModelValues(
      {this.pcindenTId,
      this.mIId,
      this.hrmEId,
      this.userid,
      this.asmaYId,
      this.roleid,
      this.pcreqtNId,
      this.pcreqtndeTId,
      this.pcindentaPId,
      this.pcmparTId,
      this.pcindentdeTId,
      this.pcreqtNDate,
      this.pcreqtNPurpose,
      this.departmentname,
      this.pcreqtNRequisitionNo,
      this.employeename,
      this.pcreqtNTotAmount,
      this.returnval,
      this.pcindenTActiveFlg,
      this.pcreqtndeTActiveFlg,
      this.pcindentdeTActiveFlg,
      this.createdate});

  RequestIndentDetailsModelValues.fromJson(Map<String, dynamic> json) {
    pcindenTId = json['pcindenT_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    userid = json['userid'];
    asmaYId = json['asmaY_Id'];
    roleid = json['roleid'];
    pcreqtNId = json['pcreqtN_Id'];
    pcreqtndeTId = json['pcreqtndeT_Id'];
    pcindentaPId = json['pcindentaP_Id'];
    pcmparTId = json['pcmparT_Id'];
    pcindentdeTId = json['pcindentdeT_Id'];
    pcreqtNDate = json['pcreqtN_Date'];
    pcreqtNPurpose = json['pcreqtN_Purpose'];
    departmentname = json['departmentname'];
    pcreqtNRequisitionNo = json['pcreqtN_RequisitionNo'];
    employeename = json['employeename'];
    pcreqtNTotAmount = json['pcreqtN_TotAmount'];
    returnval = json['returnval'];
    pcindenTActiveFlg = json['pcindenT_ActiveFlg'];
    pcreqtndeTActiveFlg = json['pcreqtndeT_ActiveFlg'];
    pcindentdeTActiveFlg = json['pcindentdeT_ActiveFlg'];
    createdate = json['createdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pcindenT_Id'] = this.pcindenTId;
    data['mI_Id'] = this.mIId;
    data['hrmE_Id'] = this.hrmEId;
    data['userid'] = this.userid;
    data['asmaY_Id'] = this.asmaYId;
    data['roleid'] = this.roleid;
    data['pcreqtN_Id'] = this.pcreqtNId;
    data['pcreqtndeT_Id'] = this.pcreqtndeTId;
    data['pcindentaP_Id'] = this.pcindentaPId;
    data['pcmparT_Id'] = this.pcmparTId;
    data['pcindentdeT_Id'] = this.pcindentdeTId;
    data['pcreqtN_Date'] = this.pcreqtNDate;
    data['pcreqtN_Purpose'] = this.pcreqtNPurpose;
    data['departmentname'] = this.departmentname;
    data['pcreqtN_RequisitionNo'] = this.pcreqtNRequisitionNo;
    data['employeename'] = this.employeename;
    data['pcreqtN_TotAmount'] = this.pcreqtNTotAmount;
    data['returnval'] = this.returnval;
    data['pcindenT_ActiveFlg'] = this.pcindenTActiveFlg;
    data['pcreqtndeT_ActiveFlg'] = this.pcreqtndeTActiveFlg;
    data['pcindentdeT_ActiveFlg'] = this.pcindentdeTActiveFlg;
    data['createdate'] = this.createdate;
    return data;
  }
}
