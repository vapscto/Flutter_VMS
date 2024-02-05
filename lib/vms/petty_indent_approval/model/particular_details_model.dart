class RequisitionParticularDetailsModel {
  String? type;
  List<RequisitionParticularDetailsModelValues>? values;

  RequisitionParticularDetailsModel({this.type, this.values});

  RequisitionParticularDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <RequisitionParticularDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(RequisitionParticularDetailsModelValues.fromJson(v));
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

class RequisitionParticularDetailsModelValues {
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
  String? pcreqtNRequisitionNo;
  String? pcreqtndeTRemarks;
  double? pcreqtndeTAmount;
  bool? returnval;
  bool? pcindenTActiveFlg;
  bool? pcreqtndeTActiveFlg;
  bool? pcindentdeTActiveFlg;

  RequisitionParticularDetailsModelValues(
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
      this.pcreqtNRequisitionNo,
      this.pcreqtndeTRemarks,
      this.pcreqtndeTAmount,
      this.returnval,
      this.pcindenTActiveFlg,
      this.pcreqtndeTActiveFlg,
      this.pcindentdeTActiveFlg});

  RequisitionParticularDetailsModelValues.fromJson(Map<String, dynamic> json) {
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
    pcreqtNRequisitionNo = json['pcreqtN_RequisitionNo'];
    pcreqtndeTRemarks = json['pcreqtndeT_Remarks'];
    pcreqtndeTAmount = json['pcreqtndeT_Amount'];
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
    data['pcreqtN_RequisitionNo'] = pcreqtNRequisitionNo;
    data['pcreqtndeT_Remarks'] = pcreqtndeTRemarks;
    data['pcreqtndeT_Amount'] = pcreqtndeTAmount;
    data['returnval'] = returnval;
    data['pcindenT_ActiveFlg'] = pcindenTActiveFlg;
    data['pcreqtndeT_ActiveFlg'] = pcreqtndeTActiveFlg;
    data['pcindentdeT_ActiveFlg'] = pcindentdeTActiveFlg;
    return data;
  }
}
