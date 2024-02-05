class ViewDataPcReqModel {
  String? type;
  List<ViewDataPcReqModelValues>? values;

  ViewDataPcReqModel({this.type, this.values});

  ViewDataPcReqModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ViewDataPcReqModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ViewDataPcReqModelValues.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['userid'] = userid;
    data['roleid'] = roleid;
    data['hrmD_Id'] = hrmDId;
    data['pcreqtN_Id'] = pcreqtNId;
    data['hrmE_Id'] = hrmEId;
    data['pcreqtndeT_Id'] = pcreqtndeTId;
    data['pcmparT_Id'] = pcmparTId;
    data['returnval'] = returnval;
    data['pcmparT_ParticularName'] = pcmparTParticularName;
    data['pcreqtndeT_Amount'] = pcreqtndeTAmount;
    data['pcreqtndeT_Remarks'] = pcreqtndeTRemarks;
    data['pcreqtndeT_ActiveFlg'] = pcreqtndeTActiveFlg;
    data['pcreqtN_ActiveFlg'] = pcreqtNActiveFlg;
    data['asmaY_Id'] = asmaYId;
    return data;
  }
}
