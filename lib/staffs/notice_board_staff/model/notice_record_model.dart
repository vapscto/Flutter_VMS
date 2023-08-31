class NoticeRecordModel {
  String? type;
  List<NoticeRecordModelValues>? values;

  NoticeRecordModel({this.type, this.values});

  NoticeRecordModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <NoticeRecordModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(NoticeRecordModelValues.fromJson(v));
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

class NoticeRecordModelValues {
  String? type;
  int? iNTBId;
  String? iNTBTitle;
  String? aSMCLClassName;
  String? aSMCSectionName;
  int? studentwise;

  NoticeRecordModelValues(
      {this.type,
      this.iNTBId,
      this.iNTBTitle,
      this.aSMCLClassName,
      this.aSMCSectionName,
      this.studentwise});

  NoticeRecordModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iNTBId = json['INTB_Id'];
    iNTBTitle = json['INTB_Title'];
    aSMCLClassName = json['ASMCL_ClassName'];
    aSMCSectionName = json['ASMC_SectionName'];
    studentwise = json['studentwise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['INTB_Id'] = iNTBId;
    data['INTB_Title'] = iNTBTitle;
    data['ASMCL_ClassName'] = aSMCLClassName;
    data['ASMC_SectionName'] = aSMCSectionName;
    data['studentwise'] = studentwise;
    return data;
  }
}
