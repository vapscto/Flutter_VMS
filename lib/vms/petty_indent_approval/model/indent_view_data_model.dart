class IndentViewDataModel {
  String? type;
  List<IndentViewDataModelValues>? values;

  IndentViewDataModel({this.type, this.values});

  IndentViewDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <IndentViewDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new IndentViewDataModelValues.fromJson(v));
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

class IndentViewDataModelValues {
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
  String? pcmparTParticularName;
  String? pcindentdeTRemarks;
  double? pcindentdeTAmount;
  double? pcindentdeTApprovedAmt;
  bool? returnval;
  bool? pcindenTActiveFlg;
  bool? pcreqtndeTActiveFlg;
  bool? pcindentdeTActiveFlg;

  IndentViewDataModelValues(
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
      this.pcmparTParticularName,
      this.pcindentdeTRemarks,
      this.pcindentdeTAmount,
      this.pcindentdeTApprovedAmt,
      this.returnval,
      this.pcindenTActiveFlg,
      this.pcreqtndeTActiveFlg,
      this.pcindentdeTActiveFlg});

  IndentViewDataModelValues.fromJson(Map<String, dynamic> json) {
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
    pcmparTParticularName = json['pcmparT_ParticularName'];
    pcindentdeTRemarks = json['pcindentdeT_Remarks'];
    pcindentdeTAmount = json['pcindentdeT_Amount'];
    pcindentdeTApprovedAmt = json['pcindentdeT_ApprovedAmt'];
    returnval = json['returnval'];
    pcindenTActiveFlg = json['pcindenT_ActiveFlg'];
    pcreqtndeTActiveFlg = json['pcreqtndeT_ActiveFlg'];
    pcindentdeTActiveFlg = json['pcindentdeT_ActiveFlg'];
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
    data['pcmparT_ParticularName'] = this.pcmparTParticularName;
    data['pcindentdeT_Remarks'] = this.pcindentdeTRemarks;
    data['pcindentdeT_Amount'] = this.pcindentdeTAmount;
    data['pcindentdeT_ApprovedAmt'] = this.pcindentdeTApprovedAmt;
    data['returnval'] = this.returnval;
    data['pcindenT_ActiveFlg'] = this.pcindenTActiveFlg;
    data['pcreqtndeT_ActiveFlg'] = this.pcreqtndeTActiveFlg;
    data['pcindentdeT_ActiveFlg'] = this.pcindentdeTActiveFlg;
    return data;
  }
}
