class StudentTimeTableModel {
  int? mIId;
  int? asmaYId;
  int? amsTId;
  int? asmcLId;
  int? asmSId;
  bool? status;
  Alldata? alldata;
  int? ttmBAfterPeriod;
  int? ttmCId;
  int? ttmPId;
  int? ttmDId;
  int? ismSId;
  int? hrmEId;
  int? ttfGId;
  int? ttfgDId;

  StudentTimeTableModel(
      {this.mIId,
      this.asmaYId,
      this.amsTId,
      this.asmcLId,
      this.asmSId,
      this.status,
      this.alldata,
      this.ttmBAfterPeriod,
      this.ttmCId,
      this.ttmPId,
      this.ttmDId,
      this.ismSId,
      this.hrmEId,
      this.ttfGId,
      this.ttfgDId});

  StudentTimeTableModel.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    amsTId = json['amsT_Id'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
    status = json['status'];
    alldata =
        json['alldata'] != null ? Alldata.fromJson(json['alldata']) : null;
    ttmBAfterPeriod = json['ttmB_AfterPeriod'];
    ttmCId = json['ttmC_Id'];
    ttmPId = json['ttmP_Id'];
    ttmDId = json['ttmD_Id'];
    ismSId = json['ismS_Id'];
    hrmEId = json['hrmE_Id'];
    ttfGId = json['ttfG_Id'];
    ttfgDId = json['ttfgD_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['amsT_Id'] = amsTId;
    data['asmcL_Id'] = asmcLId;
    data['asmS_Id'] = asmSId;
    data['status'] = status;
    if (alldata != null) {
      data['alldata'] = alldata!.toJson();
    }
    data['ttmB_AfterPeriod'] = ttmBAfterPeriod;
    data['ttmC_Id'] = ttmCId;
    data['ttmP_Id'] = ttmPId;
    data['ttmD_Id'] = ttmDId;
    data['ismS_Id'] = ismSId;
    data['hrmE_Id'] = hrmEId;
    data['ttfG_Id'] = ttfGId;
    data['ttfgD_Id'] = ttfgDId;
    return data;
  }
}

class Alldata {
  String? type;
  List<Values>? values;

  Alldata({this.type, this.values});

  Alldata.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['$values'] != null) {
      values = <Values>[];
      json['$values'].forEach((v) {
        values!.add(Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  int? mIId;
  int? asmaYId;
  int? amsTId;
  int? asmcLId;
  int? asmSId;
  String? asmcLClassName;
  String? asmCSectionName;
  bool? status;
  int? ttmBAfterPeriod;
  int? ttmCId;
  int? ttmPId;
  int? ttmDId;
  int? ismSId;
  int? hrmEId;
  int? ttfGId;
  int? ttfgDId;

  Values(
      {this.mIId,
      this.asmaYId,
      this.amsTId,
      this.asmcLId,
      this.asmSId,
      this.asmcLClassName,
      this.asmCSectionName,
      this.status,
      this.ttmBAfterPeriod,
      this.ttmCId,
      this.ttmPId,
      this.ttmDId,
      this.ismSId,
      this.hrmEId,
      this.ttfGId,
      this.ttfgDId});

  Values.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    amsTId = json['amsT_Id'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
    asmcLClassName = json['asmcL_ClassName'];
    asmCSectionName = json['asmC_SectionName'];
    status = json['status'];
    ttmBAfterPeriod = json['ttmB_AfterPeriod'];
    ttmCId = json['ttmC_Id'];
    ttmPId = json['ttmP_Id'];
    ttmDId = json['ttmD_Id'];
    ismSId = json['ismS_Id'];
    hrmEId = json['hrmE_Id'];
    ttfGId = json['ttfG_Id'];
    ttfgDId = json['ttfgD_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['amsT_Id'] = amsTId;
    data['asmcL_Id'] = asmcLId;
    data['asmS_Id'] = asmSId;
    data['asmcL_ClassName'] = asmcLClassName;
    data['asmC_SectionName'] = asmCSectionName;
    data['status'] = status;
    data['ttmB_AfterPeriod'] = ttmBAfterPeriod;
    data['ttmC_Id'] = ttmCId;
    data['ttmP_Id'] = ttmPId;
    data['ttmD_Id'] = ttmDId;
    data['ismS_Id'] = ismSId;
    data['hrmE_Id'] = hrmEId;
    data['ttfG_Id'] = ttfGId;
    data['ttfgD_Id'] = ttfgDId;
    return data;
  }
}
