class HomeWorkDataModel {
  String? type;
  List<HomeWorkDataModelValues>? values;

  HomeWorkDataModel({this.type, this.values});

  HomeWorkDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <HomeWorkDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(HomeWorkDataModelValues.fromJson(v));
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

class HomeWorkDataModelValues {
  String? type;
  int? ihWId;
  int? ihWAssignmentNo;
  String? ihWDate;
  String? ihWTopic;
  String? ihWAssignment;
  String? ihWAttachment;
  int? asmSId;
  String? ihWFilePath;
  int? ismSId;
  String? ismSSubjectName;
  int? asmcLId;
  int? filesCount;
  int? iHWUPLViewedFlg;
  int? ihwupLMarks;

  HomeWorkDataModelValues(
      {this.type,
      this.ihWId,
      this.ihWAssignmentNo,
      this.ihWDate,
      this.ihWTopic,
      this.ihWAssignment,
      this.ihWAttachment,
      this.asmSId,
      this.ihWFilePath,
      this.ismSId,
      this.ismSSubjectName,
      this.asmcLId,
      this.filesCount,
      this.iHWUPLViewedFlg,
      this.ihwupLMarks});

  HomeWorkDataModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    ihWId = json['ihW_Id'];
    ihWAssignmentNo = json['ihW_AssignmentNo'];
    ihWDate = json['ihW_Date'];
    ihWTopic = json['ihW_Topic'];
    ihWAssignment = json['ihW_Assignment'];
    ihWAttachment = json['ihW_Attachment'];
    asmSId = json['asmS_Id'];
    ihWFilePath = json['ihW_FilePath'].toString();
    ismSId = json['ismS_Id'];
    ismSSubjectName = json['ismS_SubjectName'];
    asmcLId = json['asmcL_Id'];
    filesCount = json['FilesCount'];
    iHWUPLViewedFlg = json['IHWUPL_ViewedFlg'];
    ihwupLMarks = json['ihwupL_Marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ihW_Id'] = ihWId;
    data['ihW_AssignmentNo'] = ihWAssignmentNo;
    data['ihW_Date'] = ihWDate;
    data['ihW_Topic'] = ihWTopic;
    data['ihW_Assignment'] = ihWAssignment;
    data['ihW_Attachment'] = ihWAttachment;
    data['asmS_Id'] = asmSId;
    data['ihW_FilePath'] = ihWFilePath;
    data['ismS_Id'] = ismSId;
    data['ismS_SubjectName'] = ismSSubjectName;
    data['asmcL_Id'] = asmcLId;
    data['FilesCount'] = filesCount;
    data['IHWUPL_ViewedFlg'] = iHWUPLViewedFlg;
    data['ihwupL_Marks'] = ihwupLMarks;
    return data;
  }
}
