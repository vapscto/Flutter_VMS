class ManagerWeeklyTTModel {
  List<Tt>? tt;

  ManagerWeeklyTTModel({this.tt});

  ManagerWeeklyTTModel.fromJson(Map<String, dynamic> json) {
    if (json['tt'] != null) {
      tt = <Tt>[];
      json['tt'].forEach((v) {
        tt!.add(new Tt.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tt != null) {
      data['tt'] = this.tt!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tt {
  int? asmcLId;
  int? mIId;
  String? asmcLClassName;
  bool? asmcLActiveFlag;
  int? ismSId;
  String? ismSSubjectName;
  bool? ismSActiveFlag;
  int? ttmCId;
  int? asmaYId;
  int? ttfgDId;
  int? ttfGId;
  int? asmSId;
  int? hrmEId;
  int? ttmDId;
  int? ttmPId;
  String? ttmDDayName;
  String? ttmPPeriodName;
  String? staffName;
  String? asmCSectionName;
  String? ttmCCategoryName;

  Tt(
      {this.asmcLId,
      this.mIId,
      this.asmcLClassName,
      this.asmcLActiveFlag,
      this.ismSId,
      this.ismSSubjectName,
      this.ismSActiveFlag,
      this.ttmCId,
      this.asmaYId,
      this.ttfgDId,
      this.ttfGId,
      this.asmSId,
      this.hrmEId,
      this.ttmDId,
      this.ttmPId,
      this.ttmDDayName,
      this.ttmPPeriodName,
      this.staffName,
      this.asmCSectionName,
      this.ttmCCategoryName});

  Tt.fromJson(Map<String, dynamic> json) {
    asmcLId = json['asmcL_Id'];
    mIId = json['mI_Id'];
    asmcLClassName = json['asmcL_ClassName'];
    asmcLActiveFlag = json['asmcL_ActiveFlag'];
    ismSId = json['ismS_Id'];
    ismSSubjectName = json['ismS_SubjectName'];
    ismSActiveFlag = json['ismS_ActiveFlag'];
    ttmCId = json['ttmC_Id'];
    asmaYId = json['asmaY_Id'];
    ttfgDId = json['ttfgD_Id'];
    ttfGId = json['ttfG_Id'];
    asmSId = json['asmS_Id'];
    hrmEId = json['hrmE_Id'];
    ttmDId = json['ttmD_Id'];
    ttmPId = json['ttmP_Id'];
    ttmDDayName = json['ttmD_DayName'];
    ttmPPeriodName = json['ttmP_PeriodName'];
    staffName = json['staffName'];
    asmCSectionName = json['asmC_SectionName'];
    ttmCCategoryName = json['ttmC_CategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asmcL_Id'] = this.asmcLId;
    data['mI_Id'] = this.mIId;
    data['asmcL_ClassName'] = this.asmcLClassName;
    data['asmcL_ActiveFlag'] = this.asmcLActiveFlag;
    data['ismS_Id'] = this.ismSId;
    data['ismS_SubjectName'] = this.ismSSubjectName;
    data['ismS_ActiveFlag'] = this.ismSActiveFlag;
    data['ttmC_Id'] = this.ttmCId;
    data['asmaY_Id'] = this.asmaYId;
    data['ttfgD_Id'] = this.ttfgDId;
    data['ttfG_Id'] = this.ttfGId;
    data['asmS_Id'] = this.asmSId;
    data['hrmE_Id'] = this.hrmEId;
    data['ttmD_Id'] = this.ttmDId;
    data['ttmP_Id'] = this.ttmPId;
    data['ttmD_DayName'] = this.ttmDDayName;
    data['ttmP_PeriodName'] = this.ttmPPeriodName;
    data['staffName'] = this.staffName;
    data['asmC_SectionName'] = this.asmCSectionName;
    data['ttmC_CategoryName'] = this.ttmCCategoryName;
    return data;
  }
}
