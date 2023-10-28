class IndentDetailsApprovedModel {
  String? type;
  List<IndentDetailsApprovedModelValues>? values;

  IndentDetailsApprovedModel({this.type, this.values});

  IndentDetailsApprovedModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <IndentDetailsApprovedModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new IndentDetailsApprovedModelValues.fromJson(v));
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
    data['pcindenT_IndentNo'] = this.pcindenTIndentNo;
    data['pcindenT_Date'] = this.pcindenTDate;
    data['pcindenT_Desc'] = this.pcindenTDesc;
    data['departmentname'] = this.departmentname;
    data['employeename'] = this.employeename;
    data['returnval'] = this.returnval;
    data['pcindenT_ActiveFlg'] = this.pcindenTActiveFlg;
    data['pcreqtndeT_ActiveFlg'] = this.pcreqtndeTActiveFlg;
    data['pcindentdeT_ActiveFlg'] = this.pcindentdeTActiveFlg;
    data['createdate'] = this.createdate;
    data['pcindenT_CreatedBy'] = this.pcindenTCreatedBy;
    return data;
  }
}
