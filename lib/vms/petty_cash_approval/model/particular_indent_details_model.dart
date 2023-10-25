class ParticularIndentDetailsModel {
  String? type;
  List<ParticularIndentDetailsModelValues>? values;

  ParticularIndentDetailsModel({this.type, this.values});

  ParticularIndentDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ParticularIndentDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new ParticularIndentDetailsModelValues.fromJson(v));
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

class ParticularIndentDetailsModelValues {
  int? mIId;
  int? userid;
  int? roleid;
  int? asmaYId;
  int? hrmEId;
  int? pcindentaPId;
  int? pcindentapdTId;
  int? pcreqtNId;
  int? pcmparTId;
  String? pcmparTParticularName;
  bool? pcindentapdTActiveFlg;
  String? pcindenTIndentNo;
  int? pcindenTId;
  int? pcindentdeTId;
  double? pcindentdeTAmount;
  double? pcindentdeTApprovedAmt;
  String? pcindentdeTRemarks;
  bool? pcindentdeTActiveFlg;
  bool? returnval;
  int? pcexptRId;
  bool? pcexptRActiveFlg;

  ParticularIndentDetailsModelValues(
      {this.mIId,
      this.userid,
      this.roleid,
      this.asmaYId,
      this.hrmEId,
      this.pcindentaPId,
      this.pcindentapdTId,
      this.pcreqtNId,
      this.pcmparTId,
      this.pcmparTParticularName,
      this.pcindentapdTActiveFlg,
      this.pcindenTIndentNo,
      this.pcindenTId,
      this.pcindentdeTId,
      this.pcindentdeTAmount,
      this.pcindentdeTApprovedAmt,
      this.pcindentdeTRemarks,
      this.pcindentdeTActiveFlg,
      this.returnval,
      this.pcexptRId,
      this.pcexptRActiveFlg});

  ParticularIndentDetailsModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    userid = json['userid'];
    roleid = json['roleid'];
    asmaYId = json['asmaY_Id'];
    hrmEId = json['hrmE_Id'];
    pcindentaPId = json['pcindentaP_Id'];
    pcindentapdTId = json['pcindentapdT_Id'];
    pcreqtNId = json['pcreqtN_Id'];
    pcmparTId = json['pcmparT_Id'];
    pcmparTParticularName = json['pcmparT_ParticularName'];
    pcindentapdTActiveFlg = json['pcindentapdT_ActiveFlg'];
    pcindenTIndentNo = json['pcindenT_IndentNo'];
    pcindenTId = json['pcindenT_Id'];
    pcindentdeTId = json['pcindentdeT_Id'];
    pcindentdeTAmount = json['pcindentdeT_Amount'];
    pcindentdeTApprovedAmt = json['pcindentdeT_ApprovedAmt'];
    pcindentdeTRemarks = json['pcindentdeT_Remarks'];
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
    data['pcindentapdT_Id'] = this.pcindentapdTId;
    data['pcreqtN_Id'] = this.pcreqtNId;
    data['pcmparT_Id'] = this.pcmparTId;
    data['pcmparT_ParticularName'] = this.pcmparTParticularName;
    data['pcindentapdT_ActiveFlg'] = this.pcindentapdTActiveFlg;
    data['pcindenT_IndentNo'] = this.pcindenTIndentNo;
    data['pcindenT_Id'] = this.pcindenTId;
    data['pcindentdeT_Id'] = this.pcindentdeTId;
    data['pcindentdeT_Amount'] = this.pcindentdeTAmount;
    data['pcindentdeT_ApprovedAmt'] = this.pcindentdeTApprovedAmt;
    data['pcindentdeT_Remarks'] = this.pcindentdeTRemarks;
    data['pcindentdeT_ActiveFlg'] = this.pcindentdeTActiveFlg;
    data['returnval'] = this.returnval;
    data['pcexptR_Id'] = this.pcexptRId;
    data['pcexptR_ActiveFlg'] = this.pcexptRActiveFlg;
    return data;
  }
}
