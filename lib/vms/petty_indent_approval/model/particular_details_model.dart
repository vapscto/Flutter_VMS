class RequisitionParticularDetailsModel {
  String? type;
  List<RequisitionParticularDetailsModelValues>? values;

  RequisitionParticularDetailsModel({this.type, this.values});

  RequisitionParticularDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <RequisitionParticularDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new RequisitionParticularDetailsModelValues.fromJson(v));
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
    data['pcreqtN_RequisitionNo'] = this.pcreqtNRequisitionNo;
    data['pcreqtndeT_Remarks'] = this.pcreqtndeTRemarks;
    data['pcreqtndeT_Amount'] = this.pcreqtndeTAmount;
    data['returnval'] = this.returnval;
    data['pcindenT_ActiveFlg'] = this.pcindenTActiveFlg;
    data['pcreqtndeT_ActiveFlg'] = this.pcreqtndeTActiveFlg;
    data['pcindentdeT_ActiveFlg'] = this.pcindentdeTActiveFlg;
    return data;
  }
}
