class RequestIndentDetailsModel {
  String? type;
  List<RequestIndentDetailsModelValues>? values;

  RequestIndentDetailsModel({this.type, this.values});

  RequestIndentDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <RequestIndentDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(RequestIndentDetailsModelValues.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pcindenT_Id'] = pcindenTId;
    data['mI_Id'] = mIId;
    data['hrmE_Id'] = hrmEId;
    data['userid'] = userid;
    data['asmaY_Id'] = asmaYId;
    data['roleid'] = roleid;
    data['pcreqtN_Id'] = pcreqtNId;
    data['pcreqtndeT_Id'] = pcreqtndeTId;
    data['pcindentaP_Id'] = pcindentaPId;
    data['pcmparT_Id'] = pcmparTId;
    data['pcindentdeT_Id'] = pcindentdeTId;
    data['pcreqtN_Date'] = pcreqtNDate;
    data['pcreqtN_Purpose'] = pcreqtNPurpose;
    data['departmentname'] = departmentname;
    data['pcreqtN_RequisitionNo'] = pcreqtNRequisitionNo;
    data['employeename'] = employeename;
    data['pcreqtN_TotAmount'] = pcreqtNTotAmount;
    data['returnval'] = returnval;
    data['pcindenT_ActiveFlg'] = pcindenTActiveFlg;
    data['pcreqtndeT_ActiveFlg'] = pcreqtndeTActiveFlg;
    data['pcindentdeT_ActiveFlg'] = pcindentdeTActiveFlg;
    data['createdate'] = createdate;
    return data;
  }
}
