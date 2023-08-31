class WeeklyTTClassSectionModel {
  String? type;
  List<WeeklyTTClassSectionModelValues>? values;

  WeeklyTTClassSectionModel({this.type, this.values});

  WeeklyTTClassSectionModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <WeeklyTTClassSectionModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(WeeklyTTClassSectionModelValues.fromJson(v));
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

class WeeklyTTClassSectionModelValues {
  String? type;
  int? aSMCLId;
  String? pDays;
  String? period;
  String? asmcLClassName;
  String? asmCSectionName;
  String? ismSSubjectName;

  WeeklyTTClassSectionModelValues(
      {this.type,
      this.aSMCLId,
      this.pDays,
      this.period,
      this.asmcLClassName,
      this.asmCSectionName,
      this.ismSSubjectName});

  WeeklyTTClassSectionModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    aSMCLId = json['ASMCL_Id'];
    pDays = json['p_Days'];
    period = json['period'];
    asmcLClassName = json['asmcL_ClassName'];
    asmCSectionName = json['asmC_SectionName'];
    ismSSubjectName = json['ismS_SubjectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ASMCL_Id'] = aSMCLId;
    data['p_Days'] = pDays;
    data['period'] = period;
    data['asmcL_ClassName'] = asmcLClassName;
    data['asmC_SectionName'] = asmCSectionName;
    data['ismS_SubjectName'] = ismSSubjectName;
    return data;
  }
}
