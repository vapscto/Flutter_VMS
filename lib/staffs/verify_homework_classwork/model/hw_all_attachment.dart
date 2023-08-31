class HwAllAttachmentsModel {
  String? type;
  List<HwAllAttachmentsModelValues>? values;

  HwAllAttachmentsModel({this.type, this.values});

  HwAllAttachmentsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <HwAllAttachmentsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(HwAllAttachmentsModelValues.fromJson(v));
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

class HwAllAttachmentsModelValues {
  String? type;
  int? iHWId;
  int? aMSTId;
  String? ihwuplatTFileName;
  String? ihwuplatTAttachment;
  String? studentname;
  String? amstAdmno;
  String? iHWTopic;
  String? iHWAssignment;
  String? iHWDate;
  String? iSMSSubjectName;
  int? filesCount;
  int? iHWUPLId;
  String? iHWUPLStaffRemarks;
  String? iHWFilePath1;
  num? iHWUPLMarks;

  HwAllAttachmentsModelValues(
      {this.type,
      this.iHWId,
      this.aMSTId,
      this.ihwuplatTFileName,
      this.ihwuplatTAttachment,
      this.studentname,
      this.amstAdmno,
      this.iHWTopic,
      this.iHWAssignment,
      this.iHWDate,
      this.iSMSSubjectName,
      this.filesCount,
      this.iHWUPLId,
      this.iHWUPLStaffRemarks,
      this.iHWFilePath1,
      this.iHWUPLMarks});

  HwAllAttachmentsModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iHWId = json['IHW_Id'];
    aMSTId = json['AMST_Id'];
    ihwuplatTFileName = json['ihwuplatT_FileName'];
    ihwuplatTAttachment = json['ihwuplatT_Attachment'];
    studentname = json['studentname'];
    amstAdmno = json['amst_admno'];
    iHWTopic = json['IHW_Topic'];
    iHWAssignment = json['IHW_Assignment'];
    iHWDate = json['IHW_Date'];
    iSMSSubjectName = json['ISMS_SubjectName'];
    filesCount = json['FilesCount'];
    iHWUPLId = json['IHWUPL_Id'];
    iHWUPLStaffRemarks = json['IHWUPL_StaffRemarks'];
    iHWFilePath1 = json['IHW_FilePath1'];
    iHWUPLMarks = json['IHWUPL_Marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['IHW_Id'] = iHWId;
    data['AMST_Id'] = aMSTId;
    data['ihwuplatT_FileName'] = ihwuplatTFileName;
    data['ihwuplatT_Attachment'] = ihwuplatTAttachment;
    data['studentname'] = studentname;
    data['amst_admno'] = amstAdmno;
    data['IHW_Topic'] = iHWTopic;
    data['IHW_Assignment'] = iHWAssignment;
    data['IHW_Date'] = iHWDate;
    data['ISMS_SubjectName'] = iSMSSubjectName;
    data['FilesCount'] = filesCount;
    data['IHWUPL_Id'] = iHWUPLId;
    data['IHWUPL_StaffRemarks'] = iHWUPLStaffRemarks;
    data['IHW_FilePath1'] = iHWFilePath1;
    data['IHWUPL_Marks'] = iHWUPLMarks;
    return data;
  }
}
