class ClassWorkViewWork {
  String? type;
  List<ClassWorkViewWorkValues>? values;

  ClassWorkViewWork({this.type, this.values});

  ClassWorkViewWork.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ClassWorkViewWorkValues>[];
      json['\$values'].forEach((v) {
        values!.add(ClassWorkViewWorkValues.fromJson(v));
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

class ClassWorkViewWorkValues {
  String? type;
  String? asmcLClassName;
  int? asmcLId;
  String? asmCSectionName;
  int? asmSId;
  String? ismSSubjectName;
  int? ismSId;
  int? icWId;
  String? icWContent;
  String? icWTopic;
  String? icWSubTopic;
  String? icWFromDate;
  String? icWToDate;
  bool? icWActiveFlag;
  String? icWAssignment;
  int? icWTeachingAid;
  String? icWEvaluation;
  String? icWAttachment;
  String? icWFilePath;
  int? mIId;
  int? asmaYId;
  int? filesCount;

  ClassWorkViewWorkValues(
      {this.type,
      this.asmcLClassName,
      this.asmcLId,
      this.asmCSectionName,
      this.asmSId,
      this.ismSSubjectName,
      this.ismSId,
      this.icWId,
      this.icWContent,
      this.icWTopic,
      this.icWSubTopic,
      this.icWFromDate,
      this.icWToDate,
      this.icWActiveFlag,
      this.icWAssignment,
      this.icWTeachingAid,
      this.icWEvaluation,
      this.icWAttachment,
      this.icWFilePath,
      this.mIId,
      this.asmaYId,
      this.filesCount});

  ClassWorkViewWorkValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    asmcLClassName = json['asmcL_ClassName'];
    asmcLId = json['asmcL_Id'];
    asmCSectionName = json['asmC_SectionName'];
    asmSId = json['asmS_Id'];
    ismSSubjectName = json['ismS_SubjectName'];
    ismSId = json['ismS_Id'];
    icWId = json['icW_Id'];
    icWContent = json['icW_Content'];
    icWTopic = json['icW_Topic'];
    icWSubTopic = json['icW_SubTopic'];
    icWFromDate = json['icW_FromDate'];
    icWToDate = json['icW_ToDate'];
    icWActiveFlag = json['icW_ActiveFlag'];
    icWAssignment = json['icW_Assignment'];
    icWTeachingAid = json['icW_TeachingAid'];
    icWEvaluation = json['icW_Evaluation'];
    icWAttachment = json['icW_Attachment'];
    icWFilePath = json['icW_FilePath'];
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    filesCount = json['FilesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['asmcL_ClassName'] = asmcLClassName;
    data['asmcL_Id'] = asmcLId;
    data['asmC_SectionName'] = asmCSectionName;
    data['asmS_Id'] = asmSId;
    data['ismS_SubjectName'] = ismSSubjectName;
    data['ismS_Id'] = ismSId;
    data['icW_Id'] = icWId;
    data['icW_Content'] = icWContent;
    data['icW_Topic'] = icWTopic;
    data['icW_SubTopic'] = icWSubTopic;
    data['icW_FromDate'] = icWFromDate;
    data['icW_ToDate'] = icWToDate;
    data['icW_ActiveFlag'] = icWActiveFlag;
    data['icW_Assignment'] = icWAssignment;
    data['icW_TeachingAid'] = icWTeachingAid;
    data['icW_Evaluation'] = icWEvaluation;
    data['icW_Attachment'] = icWAttachment;
    data['icW_FilePath'] = icWFilePath;
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['FilesCount'] = filesCount;
    return data;
  }
}
