class PcApprovalFromtoDateModel {
  String? type;
  List<PcApprovalFromtoDateModelValues>? values;

  PcApprovalFromtoDateModel({this.type, this.values});

  PcApprovalFromtoDateModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PcApprovalFromtoDateModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(PcApprovalFromtoDateModelValues.fromJson(v));
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

class PcApprovalFromtoDateModelValues {
  int? mIId;
  int? userid;
  int? roleid;
  int? asmaYId;
  int? hrmEId;
  int? pcindentaPId;
  String? createdate;
  int? pcindentapdTId;
  int? pcreqtNId;
  int? pcmparTId;
  bool? pcindentapdTActiveFlg;
  String? pcindenTIndentNo;
  String? departmentname;
  String? employeename;
  String? pcindenTDate;
  double? pcindenTRequestedAmount;
  double? pcindenTApprovedAmt;
  int? pcindenTId;
  int? pcindentdeTId;
  bool? pcindentdeTActiveFlg;
  bool? returnval;
  int? pcexptRId;
  bool? pcexptRActiveFlg;

  PcApprovalFromtoDateModelValues(
      {this.mIId,
      this.userid,
      this.roleid,
      this.asmaYId,
      this.hrmEId,
      this.pcindentaPId,
      this.createdate,
      this.pcindentapdTId,
      this.pcreqtNId,
      this.pcmparTId,
      this.pcindentapdTActiveFlg,
      this.pcindenTIndentNo,
      this.departmentname,
      this.employeename,
      this.pcindenTDate,
      this.pcindenTRequestedAmount,
      this.pcindenTApprovedAmt,
      this.pcindenTId,
      this.pcindentdeTId,
      this.pcindentdeTActiveFlg,
      this.returnval,
      this.pcexptRId,
      this.pcexptRActiveFlg});

  PcApprovalFromtoDateModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    userid = json['userid'];
    roleid = json['roleid'];
    asmaYId = json['asmaY_Id'];
    hrmEId = json['hrmE_Id'];
    pcindentaPId = json['pcindentaP_Id'];
    createdate = json['createdate'];
    pcindentapdTId = json['pcindentapdT_Id'];
    pcreqtNId = json['pcreqtN_Id'];
    pcmparTId = json['pcmparT_Id'];
    pcindentapdTActiveFlg = json['pcindentapdT_ActiveFlg'];
    pcindenTIndentNo = json['pcindenT_IndentNo'];
    departmentname = json['departmentname'];
    employeename = json['employeename'];
    pcindenTDate = json['pcindenT_Date'];
    pcindenTRequestedAmount = json['pcindenT_RequestedAmount'];
    pcindenTApprovedAmt = json['pcindenT_ApprovedAmt'];
    pcindenTId = json['pcindenT_Id'];
    pcindentdeTId = json['pcindentdeT_Id'];
    pcindentdeTActiveFlg = json['pcindentdeT_ActiveFlg'];
    returnval = json['returnval'];
    pcexptRId = json['pcexptR_Id'];
    pcexptRActiveFlg = json['pcexptR_ActiveFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['userid'] = userid;
    data['roleid'] = roleid;
    data['asmaY_Id'] = asmaYId;
    data['hrmE_Id'] = hrmEId;
    data['pcindentaP_Id'] = pcindentaPId;
    data['createdate'] = createdate;
    data['pcindentapdT_Id'] = pcindentapdTId;
    data['pcreqtN_Id'] = pcreqtNId;
    data['pcmparT_Id'] = pcmparTId;
    data['pcindentapdT_ActiveFlg'] = pcindentapdTActiveFlg;
    data['pcindenT_IndentNo'] = pcindenTIndentNo;
    data['departmentname'] = departmentname;
    data['employeename'] = employeename;
    data['pcindenT_Date'] = pcindenTDate;
    data['pcindenT_RequestedAmount'] = pcindenTRequestedAmount;
    data['pcindenT_ApprovedAmt'] = pcindenTApprovedAmt;
    data['pcindenT_Id'] = pcindenTId;
    data['pcindentdeT_Id'] = pcindentdeTId;
    data['pcindentdeT_ActiveFlg'] = pcindentdeTActiveFlg;
    data['returnval'] = returnval;
    data['pcexptR_Id'] = pcexptRId;
    data['pcexptR_ActiveFlg'] = pcexptRActiveFlg;
    return data;
  }
}
