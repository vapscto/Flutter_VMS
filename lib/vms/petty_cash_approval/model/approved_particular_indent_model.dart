class ParticularApprovedIndentModel {
  String? type;
  List<ParticularApprovedIndentModelValues>? values;

  ParticularApprovedIndentModel({this.type, this.values});

  ParticularApprovedIndentModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ParticularApprovedIndentModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ParticularApprovedIndentModelValues.fromJson(v));
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

class ParticularApprovedIndentModelValues {
  int? mIId;
  int? userid;
  int? roleid;
  int? asmaYId;
  int? hrmEId;
  int? pcindentaPId;
  double? pcindentapTSanctionedAmt;
  int? pcindentapdTId;
  int? pcreqtNId;
  int? pcmparTId;
  String? pcindentapdTRemarks;
  String? pcmparTParticularName;
  bool? pcindentapdTActiveFlg;
  int? pcindenTId;
  int? pcindentdeTId;
  bool? pcindentdeTActiveFlg;
  bool? returnval;
  double? pcindentapdTRequestedAmount;
  int? pcexptRId;
  bool? pcexptRActiveFlg;

  ParticularApprovedIndentModelValues(
      {this.mIId,
      this.userid,
      this.roleid,
      this.asmaYId,
      this.hrmEId,
      this.pcindentaPId,
      this.pcindentapTSanctionedAmt,
      this.pcindentapdTId,
      this.pcreqtNId,
      this.pcmparTId,
      this.pcindentapdTRemarks,
      this.pcmparTParticularName,
      this.pcindentapdTActiveFlg,
      this.pcindenTId,
      this.pcindentdeTId,
      this.pcindentdeTActiveFlg,
      this.returnval,
      this.pcindentapdTRequestedAmount,
      this.pcexptRId,
      this.pcexptRActiveFlg});

  ParticularApprovedIndentModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    userid = json['userid'];
    roleid = json['roleid'];
    asmaYId = json['asmaY_Id'];
    hrmEId = json['hrmE_Id'];
    pcindentaPId = json['pcindentaP_Id'];
    pcindentapTSanctionedAmt = json['pcindentapT_SanctionedAmt'];
    pcindentapdTId = json['pcindentapdT_Id'];
    pcreqtNId = json['pcreqtN_Id'];
    pcmparTId = json['pcmparT_Id'];
    pcindentapdTRemarks = json['pcindentapdT_Remarks'];
    pcmparTParticularName = json['pcmparT_ParticularName'];
    pcindentapdTActiveFlg = json['pcindentapdT_ActiveFlg'];
    pcindenTId = json['pcindenT_Id'];
    pcindentdeTId = json['pcindentdeT_Id'];
    pcindentdeTActiveFlg = json['pcindentdeT_ActiveFlg'];
    returnval = json['returnval'];
    pcindentapdTRequestedAmount = json['pcindentapdT_RequestedAmount'];
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
    data['pcindentapT_SanctionedAmt'] = pcindentapTSanctionedAmt;
    data['pcindentapdT_Id'] = pcindentapdTId;
    data['pcreqtN_Id'] = pcreqtNId;
    data['pcmparT_Id'] = pcmparTId;
    data['pcindentapdT_Remarks'] = pcindentapdTRemarks;
    data['pcmparT_ParticularName'] = pcmparTParticularName;
    data['pcindentapdT_ActiveFlg'] = pcindentapdTActiveFlg;
    data['pcindenT_Id'] = pcindenTId;
    data['pcindentdeT_Id'] = pcindentdeTId;
    data['pcindentdeT_ActiveFlg'] = pcindentdeTActiveFlg;
    data['returnval'] = returnval;
    data['pcindentapdT_RequestedAmount'] = pcindentapdTRequestedAmount;
    data['pcexptR_Id'] = pcexptRId;
    data['pcexptR_ActiveFlg'] = pcexptRActiveFlg;
    return data;
  }
}
