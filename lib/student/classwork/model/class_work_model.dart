class ClassWorkModel {
  String? type;
  List<ClassWorkModelValues>? values;

  ClassWorkModel({this.type, this.values});

  ClassWorkModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ClassWorkModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ClassWorkModelValues.fromJson(v));
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

class ClassWorkModelValues {
  String? type;
  String? asmcLClassName;
  String? icWContent;
  String? icWTopic;
  String? icWSubTopic;
  String? icWFromDate;
  String? icWToDate;
  String? icWAssignment;
  bool? icWActiveFlag;
  int? icWId;
  String? icWEvaluation;
  String? icWAttachment;
  String? icWFilePath;
  int? asmcLId;
  String? ismSSubjectName;
  num? icwupLMarks;
  int? filesCount;
  int? iCWUPLViewedFlg;

  ClassWorkModelValues({
    this.type,
    this.asmcLClassName,
    this.icWContent,
    this.icWTopic,
    this.icWSubTopic,
    this.icWFromDate,
    this.icWToDate,
    this.icWAssignment,
    this.icWActiveFlag,
    this.icWId,
    this.icWEvaluation,
    this.icWAttachment,
    this.icWFilePath,
    this.asmcLId,
    this.ismSSubjectName,
    this.icwupLMarks,
    this.filesCount,
    this.iCWUPLViewedFlg,
  });

  ClassWorkModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    asmcLClassName = json['asmcL_ClassName'];
    icWContent = json['icW_Content'];
    icWTopic = json['icW_Topic'];
    icWSubTopic = json['icW_SubTopic'];
    icWFromDate = json['icW_FromDate'];
    icWToDate = json['icW_ToDate'];
    icWAssignment = json['icW_Assignment'];
    icWActiveFlag = json['icW_ActiveFlag'];
    icWId = json['icW_Id'];
    icWEvaluation = json['icW_Evaluation'];
    icWAttachment = json['icW_Attachment'];
    icWFilePath = json['icW_FilePath'].toString();
    asmcLId = json['asmcL_Id'];
    ismSSubjectName = json['ismS_SubjectName'];
    icwupLMarks = json['icwupL_Marks'];
    filesCount = json['FilesCount'];
    iCWUPLViewedFlg = json['ICWUPL_ViewedFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['asmcL_ClassName'] = asmcLClassName;
    data['icW_Content'] = icWContent;
    data['icW_Topic'] = icWTopic;
    data['icW_SubTopic'] = icWSubTopic;
    data['icW_FromDate'] = icWFromDate;
    data['icW_ToDate'] = icWToDate;
    data['icW_Assignment'] = icWAssignment;
    data['icW_ActiveFlag'] = icWActiveFlag;
    data['icW_Id'] = icWId;
    data['icW_Evaluation'] = icWEvaluation;
    data['icW_Attachment'] = icWAttachment;
    data['icW_FilePath'] = icWFilePath;
    data['asmcL_Id'] = asmcLId;
    data['ismS_SubjectName'] = ismSSubjectName;
    data['icwupL_Marks'] = icwupLMarks;
    data['FilesCount'] = filesCount;
    data['ICWUPL_ViewedFlg'] = iCWUPLViewedFlg;
    return data;
  }
}
