class ViewDataPcReqModel {
  String? type;
  List<ViewDataPcReqModelValues>? values;

  ViewDataPcReqModel({this.type, this.values});

  ViewDataPcReqModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ViewDataPcReqModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new ViewDataPcReqModelValues.fromJson(v));
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

class ViewDataPcReqModelValues {
  int? mIId;
  int? userid;
  int? roleid;
  int? hrmDId;
  int? pcreqtNId;
  int? hrmEId;
  int? pcreqtndeTId;
  int? pcmparTId;
  bool? returnval;
  String? pcmparTParticularName;
  double? pcreqtndeTAmount;
  String? pcreqtndeTRemarks;
  bool? pcreqtndeTActiveFlg;
  bool? pcreqtNActiveFlg;
  int? asmaYId;

  ViewDataPcReqModelValues(
      {this.mIId,
      this.userid,
      this.roleid,
      this.hrmDId,
      this.pcreqtNId,
      this.hrmEId,
      this.pcreqtndeTId,
      this.pcmparTId,
      this.returnval,
      this.pcmparTParticularName,
      this.pcreqtndeTAmount,
      this.pcreqtndeTRemarks,
      this.pcreqtndeTActiveFlg,
      this.pcreqtNActiveFlg,
      this.asmaYId});

  ViewDataPcReqModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    userid = json['userid'];
    roleid = json['roleid'];
    hrmDId = json['hrmD_Id'];
    pcreqtNId = json['pcreqtN_Id'];
    hrmEId = json['hrmE_Id'];
    pcreqtndeTId = json['pcreqtndeT_Id'];
    pcmparTId = json['pcmparT_Id'];
    returnval = json['returnval'];
    pcmparTParticularName = json['pcmparT_ParticularName'];
    pcreqtndeTAmount = json['pcreqtndeT_Amount'];
    pcreqtndeTRemarks = json['pcreqtndeT_Remarks'];
    pcreqtndeTActiveFlg = json['pcreqtndeT_ActiveFlg'];
    pcreqtNActiveFlg = json['pcreqtN_ActiveFlg'];
    asmaYId = json['asmaY_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mI_Id'] = this.mIId;
    data['userid'] = this.userid;
    data['roleid'] = this.roleid;
    data['hrmD_Id'] = this.hrmDId;
    data['pcreqtN_Id'] = this.pcreqtNId;
    data['hrmE_Id'] = this.hrmEId;
    data['pcreqtndeT_Id'] = this.pcreqtndeTId;
    data['pcmparT_Id'] = this.pcmparTId;
    data['returnval'] = this.returnval;
    data['pcmparT_ParticularName'] = this.pcmparTParticularName;
    data['pcreqtndeT_Amount'] = this.pcreqtndeTAmount;
    data['pcreqtndeT_Remarks'] = this.pcreqtndeTRemarks;
    data['pcreqtndeT_ActiveFlg'] = this.pcreqtndeTActiveFlg;
    data['pcreqtN_ActiveFlg'] = this.pcreqtNActiveFlg;
    data['asmaY_Id'] = this.asmaYId;
    return data;
  }
}
