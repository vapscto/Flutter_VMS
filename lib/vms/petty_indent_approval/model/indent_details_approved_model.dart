class IndentDetailsApprovedModel {
  String? type;
  List<IndentDetailsApprovedModelValues>? values;

  IndentDetailsApprovedModel({this.type, this.values});

  IndentDetailsApprovedModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <IndentDetailsApprovedModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(IndentDetailsApprovedModelValues.fromJson(v));
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

class IndentDetailsApprovedModelValues {
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
  String? pcindenTIndentNo;
  String? pcindenTDate;
  String? pcindenTDesc;
  String? departmentname;
  String? employeename;
  bool? returnval;
  bool? pcindenTActiveFlg;
  bool? pcreqtndeTActiveFlg;
  bool? pcindentdeTActiveFlg;
  String? createdate;
  int? pcindenTCreatedBy;

  IndentDetailsApprovedModelValues(
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
      this.pcindenTIndentNo,
      this.pcindenTDate,
      this.pcindenTDesc,
      this.departmentname,
      this.employeename,
      this.returnval,
      this.pcindenTActiveFlg,
      this.pcreqtndeTActiveFlg,
      this.pcindentdeTActiveFlg,
      this.createdate,
      this.pcindenTCreatedBy});

  IndentDetailsApprovedModelValues.fromJson(Map<String, dynamic> json) {
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
    pcindenTIndentNo = json['pcindenT_IndentNo'];
    pcindenTDate = json['pcindenT_Date'];
    pcindenTDesc = json['pcindenT_Desc'];
    departmentname = json['departmentname'];
    employeename = json['employeename'];
    returnval = json['returnval'];
    pcindenTActiveFlg = json['pcindenT_ActiveFlg'];
    pcreqtndeTActiveFlg = json['pcreqtndeT_ActiveFlg'];
    pcindentdeTActiveFlg = json['pcindentdeT_ActiveFlg'];
    createdate = json['createdate'];
    pcindenTCreatedBy = json['pcindenT_CreatedBy'];
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
    data['pcindenT_IndentNo'] = pcindenTIndentNo;
    data['pcindenT_Date'] = pcindenTDate;
    data['pcindenT_Desc'] = pcindenTDesc;
    data['departmentname'] = departmentname;
    data['employeename'] = employeename;
    data['returnval'] = returnval;
    data['pcindenT_ActiveFlg'] = pcindenTActiveFlg;
    data['pcreqtndeT_ActiveFlg'] = pcreqtndeTActiveFlg;
    data['pcindentdeT_ActiveFlg'] = pcindentdeTActiveFlg;
    data['createdate'] = createdate;
    data['pcindenT_CreatedBy'] = pcindenTCreatedBy;
    return data;
  }
}
