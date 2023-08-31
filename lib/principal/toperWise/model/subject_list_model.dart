class TopSubjectListModel {
  String? type;
  List<TopSubjectListModelValues>? values;

  TopSubjectListModel({this.type, this.values});

  TopSubjectListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TopSubjectListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new TopSubjectListModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopSubjectListModelValues {
  int? ismSId;
  int? mIId;
  String? ismSSubjectName;
  String? ismSSubjectCode;
  String? ismSIVRSSubjectName;
  double? ismSMaxMarks;
  double? ismSMinMarks;
  int? ismSExamFlag;
  int? ismSPreadmFlag;
  int? ismSSubjectFlag;
  int? ismSBatchAppl;
  int? ismSActiveFlag;
  int? ismSOrderFlag;
  bool? ismSTTFlag;
  bool? ismSAttendanceFlag;
  int? ismSLanguageFlg;
  int? ismSAtExtraFeeFlg;
  bool? ismSDiscontinuedFlg;
  String? ismSSubjectNameNew;

  String? createdDate;
  String? updatedDate;

  TopSubjectListModelValues(
      {this.ismSId,
      this.mIId,
      this.ismSSubjectName,
      this.ismSSubjectCode,
      this.ismSIVRSSubjectName,
      this.ismSMaxMarks,
      this.ismSMinMarks,
      this.ismSExamFlag,
      this.ismSPreadmFlag,
      this.ismSSubjectFlag,
      this.ismSBatchAppl,
      this.ismSActiveFlag,
      this.ismSOrderFlag,
      this.ismSTTFlag,
      this.ismSAttendanceFlag,
      this.ismSLanguageFlg,
      this.ismSAtExtraFeeFlg,
      this.ismSDiscontinuedFlg,
      this.createdDate,
      this.updatedDate,
      this.ismSSubjectNameNew});

  TopSubjectListModelValues.fromJson(Map<String, dynamic> json) {
    ismSId = json['ismS_Id'];
    mIId = json['mI_Id'];
    ismSSubjectName = json['ismS_SubjectName'];
    ismSSubjectCode = json['ismS_SubjectCode'];
    ismSIVRSSubjectName = json['ismS_IVRSSubjectName'];
    ismSMaxMarks = json['ismS_Max_Marks'];
    ismSMinMarks = json['ismS_Min_Marks'];
    ismSExamFlag = json['ismS_ExamFlag'];
    ismSPreadmFlag = json['ismS_PreadmFlag'];
    ismSSubjectFlag = json['ismS_SubjectFlag'];
    ismSBatchAppl = json['ismS_BatchAppl'];
    ismSActiveFlag = json['ismS_ActiveFlag'];
    ismSOrderFlag = json['ismS_OrderFlag'];
    ismSTTFlag = json['ismS_TTFlag'];
    ismSAttendanceFlag = json['ismS_AttendanceFlag'];
    ismSLanguageFlg = json['ismS_LanguageFlg'];
    ismSAtExtraFeeFlg = json['ismS_AtExtraFeeFlg'];
    ismSDiscontinuedFlg = json['ismS_DiscontinuedFlg'];
      ismSSubjectNameNew = json['ismS_SubjectNameNew'];

createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ismS_Id'] = this.ismSId;
    data['mI_Id'] = this.mIId;
    data['ismS_SubjectName'] = this.ismSSubjectName;
    data['ismS_SubjectCode'] = this.ismSSubjectCode;
    data['ismS_IVRSSubjectName'] = this.ismSIVRSSubjectName;
    data['ismS_Max_Marks'] = this.ismSMaxMarks;
    data['ismS_Min_Marks'] = this.ismSMinMarks;
    data['ismS_ExamFlag'] = this.ismSExamFlag;
    data['ismS_PreadmFlag'] = this.ismSPreadmFlag;
    data['ismS_SubjectFlag'] = this.ismSSubjectFlag;
    data['ismS_BatchAppl'] = this.ismSBatchAppl;
    data['ismS_ActiveFlag'] = this.ismSActiveFlag;
    data['ismS_OrderFlag'] = this.ismSOrderFlag;
    data['ismS_TTFlag'] = this.ismSTTFlag;
    data['ismS_AttendanceFlag'] = this.ismSAttendanceFlag;
    data['ismS_LanguageFlg'] = this.ismSLanguageFlg;
    data['ismS_AtExtraFeeFlg'] = this.ismSAtExtraFeeFlg;
    data['ismS_DiscontinuedFlg'] = this.ismSDiscontinuedFlg;
    
    data['ismS_SubjectNameNew'] = this.ismSSubjectNameNew;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}
