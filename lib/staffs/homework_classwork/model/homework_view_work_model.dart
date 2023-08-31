class HomeWorkViewWork {
  String? type;
  List<HomeWorkViewWorkValues>? values;

  HomeWorkViewWork({this.type, this.values});

  HomeWorkViewWork.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <HomeWorkViewWorkValues>[];
      json['\$values'].forEach((v) {
        values!.add(HomeWorkViewWorkValues.fromJson(v));
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

class HomeWorkViewWorkValues {
  String? type;
  String? asmcLClassName;
  String? asmCSectionName;
  String? ismSSubjectName;
  int? iHWAssignmentNo;
  String? ihWAttachment;
  String? ihWAssignment;
  String? ihWDate;
  String? ihWTopic;
  bool? ihWActiveFlag;
  int? ihWId;
  int? asmaYId;
  int? iVRMULId;
  String? iHWFilePath;
  int? filesCount;

  HomeWorkViewWorkValues(
      {this.type,
      this.asmcLClassName,
      this.asmCSectionName,
      this.ismSSubjectName,
      this.iHWAssignmentNo,
      this.ihWAttachment,
      this.ihWAssignment,
      this.ihWDate,
      this.ihWTopic,
      this.ihWActiveFlag,
      this.ihWId,
      this.asmaYId,
      this.iVRMULId,
      this.iHWFilePath,
      this.filesCount});

  HomeWorkViewWorkValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    asmcLClassName = json['asmcL_ClassName'];
    asmCSectionName = json['asmC_SectionName'];
    ismSSubjectName = json['ismS_SubjectName'];
    iHWAssignmentNo = json['IHW_AssignmentNo'];
    ihWAttachment = json['ihW_Attachment'];
    ihWAssignment = json['ihW_Assignment'];
    ihWDate = json['ihW_Date'];
    ihWTopic = json['ihW_Topic'];
    ihWActiveFlag = json['ihW_ActiveFlag'];
    ihWId = json['ihW_Id'];
    asmaYId = json['asmaY_Id'];
    iVRMULId = json['IVRMUL_Id'];
    iHWFilePath = json['IHW_FilePath'];
    filesCount = json['FilesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['asmcL_ClassName'] = asmcLClassName;
    data['asmC_SectionName'] = asmCSectionName;
    data['ismS_SubjectName'] = ismSSubjectName;
    data['IHW_AssignmentNo'] = iHWAssignmentNo;
    data['ihW_Attachment'] = ihWAttachment;
    data['ihW_Assignment'] = ihWAssignment;
    data['ihW_Date'] = ihWDate;
    data['ihW_Topic'] = ihWTopic;
    data['ihW_ActiveFlag'] = ihWActiveFlag;
    data['ihW_Id'] = ihWId;
    data['asmaY_Id'] = asmaYId;
    data['IVRMUL_Id'] = iVRMULId;
    data['IHW_FilePath'] = iHWFilePath;
    data['FilesCount'] = filesCount;
    return data;
  }
}
