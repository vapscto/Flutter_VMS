class ViewNoticeDetailsModelValues {
  String? type;
  List<ViewNoticeDetailsModelValuesValues>? values;

  ViewNoticeDetailsModelValues({this.type, this.values});

  ViewNoticeDetailsModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ViewNoticeDetailsModelValuesValues>[];
      json['\$values'].forEach((v) {
        values!.add(ViewNoticeDetailsModelValuesValues.fromJson(v));
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

class ViewNoticeDetailsModelValuesValues {
  String? type;
  int? intBId;
  String? intBTitle;
  String? intBDescription;
  String? intBStartDate;
  String? intBEndDate;
  String? intBDisplayDate;
  bool? intBActiveFlag;
  bool? iNTBToStaffFlg;
  bool? iNTBToStudentFlg;
  int? filesCount;

  ViewNoticeDetailsModelValuesValues(
      {this.type,
      this.intBId,
      this.intBTitle,
      this.intBDescription,
      this.intBStartDate,
      this.intBEndDate,
      this.intBDisplayDate,
      this.intBActiveFlag,
      this.iNTBToStaffFlg,
      this.iNTBToStudentFlg,
      this.filesCount});

  ViewNoticeDetailsModelValuesValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    intBId = json['intB_Id'];
    intBTitle = json['intB_Title'];
    intBDescription = json['intB_Description'];
    intBStartDate = json['intB_StartDate'];
    intBEndDate = json['intB_EndDate'];
    intBDisplayDate = json['intB_DisplayDate'];
    intBActiveFlag = json['intB_ActiveFlag'];
    iNTBToStaffFlg = json['INTB_ToStaffFlg'];
    iNTBToStudentFlg = json['INTB_ToStudentFlg'];
    filesCount = json['FilesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['intB_Id'] = intBId;
    data['intB_Title'] = intBTitle;
    data['intB_Description'] = intBDescription;
    data['intB_StartDate'] = intBStartDate;
    data['intB_EndDate'] = intBEndDate;
    data['intB_DisplayDate'] = intBDisplayDate;
    data['intB_ActiveFlag'] = intBActiveFlag;
    data['INTB_ToStaffFlg'] = iNTBToStaffFlg;
    data['INTB_ToStudentFlg'] = iNTBToStudentFlg;
    data['FilesCount'] = filesCount;
    return data;
  }
}
