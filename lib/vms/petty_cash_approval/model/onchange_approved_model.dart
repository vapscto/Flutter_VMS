class PCApprovalOnChangeModel {
  String? type;
  List<PCApprovalOnChangeModelValues>? values;

  PCApprovalOnChangeModel({this.type, this.values});

  PCApprovalOnChangeModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PCApprovalOnChangeModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new PCApprovalOnChangeModelValues.fromJson(v));
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

class PCApprovalOnChangeModelValues {
  int? mIId;
  int? userid;
  int? roleid;
  int? asmaYId;
  int? hrmEId;
  int? pcindentaPId;
  String? pcindentapTIndentNo;
  String? pcindentapTDate;
  String? createdate;
  String? pcindentapTDesc;
  double? pcindentapTSanctionedAmt;
  int? pcindentapdTId;
  int? pcreqtNId;
  int? pcmparTId;
  bool? pcindentapdTActiveFlg;
  String? departmentname;
  String? employeename;
  int? pcindenTId;
  int? pcindentdeTId;
  bool? pcindentdeTActiveFlg;
  bool? returnval;
  int? pcexptRId;
  bool? pcexptRActiveFlg;

  PCApprovalOnChangeModelValues(
      {this.mIId,
      this.userid,
      this.roleid,
      this.asmaYId,
      this.hrmEId,
      this.pcindentaPId,
      this.pcindentapTIndentNo,
      this.pcindentapTDate,
      this.createdate,
      this.pcindentapTDesc,
      this.pcindentapTSanctionedAmt,
      this.pcindentapdTId,
      this.pcreqtNId,
      this.pcmparTId,
      this.pcindentapdTActiveFlg,
      this.departmentname,
      this.employeename,
      this.pcindenTId,
      this.pcindentdeTId,
      this.pcindentdeTActiveFlg,
      this.returnval,
      this.pcexptRId,
      this.pcexptRActiveFlg});

  PCApprovalOnChangeModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    userid = json['userid'];
    roleid = json['roleid'];
    asmaYId = json['asmaY_Id'];
    hrmEId = json['hrmE_Id'];
    pcindentaPId = json['pcindentaP_Id'];
    pcindentapTIndentNo = json['pcindentapT_IndentNo'];
    pcindentapTDate = json['pcindentapT_Date'];
    createdate = json['createdate'];
    pcindentapTDesc = json['pcindentapT_Desc'];
    pcindentapTSanctionedAmt = json['pcindentapT_SanctionedAmt'];
    pcindentapdTId = json['pcindentapdT_Id'];
    pcreqtNId = json['pcreqtN_Id'];
    pcmparTId = json['pcmparT_Id'];
    pcindentapdTActiveFlg = json['pcindentapdT_ActiveFlg'];
    departmentname = json['departmentname'];
    employeename = json['employeename'];
    pcindenTId = json['pcindenT_Id'];
    pcindentdeTId = json['pcindentdeT_Id'];
    pcindentdeTActiveFlg = json['pcindentdeT_ActiveFlg'];
    returnval = json['returnval'];
    pcexptRId = json['pcexptR_Id'];
    pcexptRActiveFlg = json['pcexptR_ActiveFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mI_Id'] = this.mIId;
    data['userid'] = this.userid;
    data['roleid'] = this.roleid;
    data['asmaY_Id'] = this.asmaYId;
    data['hrmE_Id'] = this.hrmEId;
    data['pcindentaP_Id'] = this.pcindentaPId;
    data['pcindentapT_IndentNo'] = this.pcindentapTIndentNo;
    data['pcindentapT_Date'] = this.pcindentapTDate;
    data['createdate'] = this.createdate;
    data['pcindentapT_Desc'] = this.pcindentapTDesc;
    data['pcindentapT_SanctionedAmt'] = this.pcindentapTSanctionedAmt;
    data['pcindentapdT_Id'] = this.pcindentapdTId;
    data['pcreqtN_Id'] = this.pcreqtNId;
    data['pcmparT_Id'] = this.pcmparTId;
    data['pcindentapdT_ActiveFlg'] = this.pcindentapdTActiveFlg;
    data['departmentname'] = this.departmentname;
    data['employeename'] = this.employeename;
    data['pcindenT_Id'] = this.pcindenTId;
    data['pcindentdeT_Id'] = this.pcindentdeTId;
    data['pcindentdeT_ActiveFlg'] = this.pcindentdeTActiveFlg;
    data['returnval'] = this.returnval;
    data['pcexptR_Id'] = this.pcexptRId;
    data['pcexptR_ActiveFlg'] = this.pcexptRActiveFlg;
    return data;
  }
}
