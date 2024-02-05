class IndentViewDataModel {
  String? type;
  List<IndentViewDataModelValues>? values;

  IndentViewDataModel({this.type, this.values});

  IndentViewDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <IndentViewDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(IndentViewDataModelValues.fromJson(v));
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
    data['pcmparT_ParticularName'] = pcmparTParticularName;
    data['pcindentdeT_Remarks'] = pcindentdeTRemarks;
    data['pcindentdeT_Amount'] = pcindentdeTAmount;
    data['pcindentdeT_ApprovedAmt'] = pcindentdeTApprovedAmt;
    data['returnval'] = returnval;
    data['pcindenT_ActiveFlg'] = pcindenTActiveFlg;
    data['pcreqtndeT_ActiveFlg'] = pcreqtndeTActiveFlg;
    data['pcindentdeT_ActiveFlg'] = pcindentdeTActiveFlg;
    return data;
  }
}
