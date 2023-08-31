class TTModel {
  String? type;
  List<TTModelValues>? values;

  TTModel({this.type, this.values});

  TTModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TTModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TTModelValues.fromJson(v));
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

class TTModelValues {
  int? mIId;
  int? asmaYId;
  int? amsTId;
  int? asmcLId;
  int? asmSId;
  String? asmcLClassName;
  String? asmCSectionName;
  bool? status;
  double? ttmBAfterPeriod;
  String? staffName;
  String? ismSSubjectName;
  String? ttmCCategoryName;
  String? ttmPPeriodName;
  String? ttmDDayName;
  int? ttmCId;
  int? ttmPId;
  int? ttmDId;
  int? ismSId;
  int? hrmEId;
  int? ttfGId;
  int? ttfgDId;

  TTModelValues(
      {this.mIId,
      this.asmaYId,
      this.amsTId,
      this.asmcLId,
      this.asmSId,
      this.asmcLClassName,
      this.asmCSectionName,
      this.status,
      this.ttmBAfterPeriod,
      this.staffName,
      this.ismSSubjectName,
      this.ttmCCategoryName,
      this.ttmPPeriodName,
      this.ttmDDayName,
      this.ttmCId,
      this.ttmPId,
      this.ttmDId,
      this.ismSId,
      this.hrmEId,
      this.ttfGId,
      this.ttfgDId});

  TTModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    amsTId = json['amsT_Id'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
    asmcLClassName = json['asmcL_ClassName'];
    asmCSectionName = json['asmC_SectionName'];
    status = json['status'];
    ttmBAfterPeriod = json['ttmB_AfterPeriod'];
    staffName = json['staffName'];
    ismSSubjectName = json['ismS_SubjectName'];
    ttmCCategoryName = json['ttmC_CategoryName'];
    ttmPPeriodName = json['ttmP_PeriodName'];
    ttmDDayName = json['ttmD_DayName'];
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
    data['staffName'] = staffName;
    data['ismS_SubjectName'] = ismSSubjectName;
    data['ttmC_CategoryName'] = ttmCCategoryName;
    data['ttmP_PeriodName'] = ttmPPeriodName;
    data['ttmD_DayName'] = ttmDDayName;
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
