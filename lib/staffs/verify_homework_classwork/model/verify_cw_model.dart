class VerifyClassworkList {
  String? type;
  List<VerifyClassworkListValues>? values;

  VerifyClassworkList({this.type, this.values});

  VerifyClassworkList.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <VerifyClassworkListValues>[];
      json['\$values'].forEach((v) {
        values!.add(VerifyClassworkListValues.fromJson(v));
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

class VerifyClassworkListValues {
  String? type;
  int? iCWUPLId;
  int? iCWId;
  int? aMSTId;
  String? studentname;
  String? amstAdmno;
  String? iCWTopic;
  String? iCWSubTopic;
  String? iCWContent;
  String? iCWAssignment;
  String? iCWFromDate;
  String? iCWToDate;
  String? iSMSSubjectName;
  int? filesCount;
  double? iCWUPLMarks;
  String? iCWUPLStaffRemarks;
  String? iCWFilePath1;
  String? fileName1;
  String? aMSTPhotoname;

  VerifyClassworkListValues(
      {this.type,
      this.iCWUPLId,
      this.iCWId,
      this.aMSTId,
      this.studentname,
      this.amstAdmno,
      this.iCWTopic,
      this.iCWSubTopic,
      this.iCWContent,
      this.iCWAssignment,
      this.iCWFromDate,
      this.iCWToDate,
      this.iSMSSubjectName,
      this.filesCount,
      this.iCWUPLMarks,
      this.iCWUPLStaffRemarks,
      this.iCWFilePath1,
      this.fileName1,
      this.aMSTPhotoname});

  VerifyClassworkListValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iCWUPLId = json['ICWUPL_Id'];
    iCWId = json['ICW_Id'];
    aMSTId = json['AMST_Id'];
    studentname = json['studentname'];
    amstAdmno = json['amst_admno'];
    iCWTopic = json['ICW_Topic'];
    iCWSubTopic = json['ICW_SubTopic'];
    iCWContent = json['ICW_Content'];
    iCWAssignment = json['ICW_Assignment'];
    iCWFromDate = json['ICW_FromDate'];
    iCWToDate = json['ICW_ToDate'];
    iSMSSubjectName = json['ISMS_SubjectName'];
    filesCount = json['FilesCount'];
    iCWUPLMarks = json['ICWUPL_Marks'];
    iCWUPLStaffRemarks = json['ICWUPL_StaffRemarks'];
    iCWFilePath1 = json['ICW_FilePath1'];
    fileName1 = json['FileName1'];
    aMSTPhotoname = json['AMST_Photoname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ICWUPL_Id'] = iCWUPLId;
    data['ICW_Id'] = iCWId;
    data['AMST_Id'] = aMSTId;
    data['studentname'] = studentname;
    data['amst_admno'] = amstAdmno;
    data['ICW_Topic'] = iCWTopic;
    data['ICW_SubTopic'] = iCWSubTopic;
    data['ICW_Content'] = iCWContent;
    data['ICW_Assignment'] = iCWAssignment;
    data['ICW_FromDate'] = iCWFromDate;
    data['ICW_ToDate'] = iCWToDate;
    data['ISMS_SubjectName'] = iSMSSubjectName;
    data['FilesCount'] = filesCount;
    data['ICWUPL_Marks'] = iCWUPLMarks;
    data['ICWUPL_StaffRemarks'] = iCWUPLStaffRemarks;
    data['ICW_FilePath1'] = iCWFilePath1;
    data['FileName1'] = fileName1;
    data['AMST_Photoname'] = aMSTPhotoname;
    return data;
  }
}
