class SubjectWiseDataModel {
  String? type;
  List<SubjectWiseDataModelValues>? values;

  SubjectWiseDataModel({this.type, this.values});

  SubjectWiseDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <SubjectWiseDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(SubjectWiseDataModelValues.fromJson(v));
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

class SubjectWiseDataModelValues {
  String? type;
  int? iSMSId;
  String? iSMSIVRSSubjectName;
  int? iSMSOrderFlag;
  num? eSTMPSMaxMarks;
  num? eSTMPSObtainedMarks;
  String? eSTMPSObtainedGrade;
  num? eSTMPSClassHighest;
  num? eSTMPSClassAverage;
  num? eSTMPSSectionAverage;
  String? eSTMPSPassFailFlg;

  SubjectWiseDataModelValues(
      {this.type,
      this.iSMSId,
      this.iSMSIVRSSubjectName,
      this.iSMSOrderFlag,
      this.eSTMPSMaxMarks,
      this.eSTMPSObtainedMarks,
      this.eSTMPSObtainedGrade,
      this.eSTMPSClassHighest,
      this.eSTMPSClassAverage,
      this.eSTMPSSectionAverage,
      this.eSTMPSPassFailFlg});

  SubjectWiseDataModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMSId = json['ISMS_Id'];
    iSMSIVRSSubjectName = json['ISMS_IVRSSubjectName'];
    iSMSOrderFlag = json['ISMS_OrderFlag'];
    eSTMPSMaxMarks = json['ESTMPS_MaxMarks'];
    eSTMPSObtainedMarks = json['ESTMPS_ObtainedMarks'];
    eSTMPSObtainedGrade = json['ESTMPS_ObtainedGrade'];
    eSTMPSClassHighest = json['ESTMPS_ClassHighest'];
    eSTMPSClassAverage = json['ESTMPS_ClassAverage'];
    eSTMPSSectionAverage = json['ESTMPS_SectionAverage'];
    eSTMPSPassFailFlg = json['ESTMPS_PassFailFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMS_Id'] = iSMSId;
    data['ISMS_IVRSSubjectName'] = iSMSIVRSSubjectName;
    data['ISMS_OrderFlag'] = iSMSOrderFlag;
    data['ESTMPS_MaxMarks'] = eSTMPSMaxMarks;
    data['ESTMPS_ObtainedMarks'] = eSTMPSObtainedMarks;
    data['ESTMPS_ObtainedGrade'] = eSTMPSObtainedGrade;
    data['ESTMPS_ClassHighest'] = eSTMPSClassHighest;
    data['ESTMPS_ClassAverage'] = eSTMPSClassAverage;
    data['ESTMPS_SectionAverage'] = eSTMPSSectionAverage;
    data['ESTMPS_PassFailFlg'] = eSTMPSPassFailFlg;
    return data;
  }
}
