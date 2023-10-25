class ParticularApprovedIndentModel {
  String? type;
  List<ParticularApprovedIndentModelValues>? values;

  ParticularApprovedIndentModel({this.type, this.values});

  ParticularApprovedIndentModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ParticularApprovedIndentModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new ParticularApprovedIndentModelValues.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mI_Id'] = this.mIId;
    data['userid'] = this.userid;
    data['roleid'] = this.roleid;
    data['asmaY_Id'] = this.asmaYId;
    data['hrmE_Id'] = this.hrmEId;
    data['pcindentaP_Id'] = this.pcindentaPId;
    data['pcindentapT_SanctionedAmt'] = this.pcindentapTSanctionedAmt;
    data['pcindentapdT_Id'] = this.pcindentapdTId;
    data['pcreqtN_Id'] = this.pcreqtNId;
    data['pcmparT_Id'] = this.pcmparTId;
    data['pcindentapdT_Remarks'] = this.pcindentapdTRemarks;
    data['pcmparT_ParticularName'] = this.pcmparTParticularName;
    data['pcindentapdT_ActiveFlg'] = this.pcindentapdTActiveFlg;
    data['pcindenT_Id'] = this.pcindenTId;
    data['pcindentdeT_Id'] = this.pcindentdeTId;
    data['pcindentdeT_ActiveFlg'] = this.pcindentdeTActiveFlg;
    data['returnval'] = this.returnval;
    data['pcindentapdT_RequestedAmount'] = this.pcindentapdTRequestedAmount;
    data['pcexptR_Id'] = this.pcexptRId;
    data['pcexptR_ActiveFlg'] = this.pcexptRActiveFlg;
    return data;
  }
}
