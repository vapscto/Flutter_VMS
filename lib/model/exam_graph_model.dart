class ExamGraphList {
  String? type;
  List<ExamGraphListValues>? values;

  ExamGraphList({this.type, this.values});

  ExamGraphList.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ExamGraphListValues>[];
      json['\$values'].forEach((v) {
        values!.add(ExamGraphListValues.fromJson(v));
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

class ExamGraphListValues {
  String? type;
  int? eMEExamOrder;
  int? iSMSOrderFlag;
  int? aMSTId;
  int? iSMSId;
  int? eMEId;
  String? eMEExamName;
  String? iSMSSubjectName;
  double? eSTMPSMaxMarks;
  double? eSTMPSObtainedMarks;

  ExamGraphListValues(
      {this.type,
      this.eMEExamOrder,
      this.iSMSOrderFlag,
      this.aMSTId,
      this.iSMSId,
      this.eMEId,
      this.eMEExamName,
      this.iSMSSubjectName,
      this.eSTMPSMaxMarks,
      this.eSTMPSObtainedMarks});

  ExamGraphListValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    eMEExamOrder = json['EME_ExamOrder'];
    iSMSOrderFlag = json['ISMS_OrderFlag'];
    aMSTId = json['AMST_Id'];
    iSMSId = json['ISMS_Id'];
    eMEId = json['EME_Id'];
    eMEExamName = json['EME_ExamName'];
    iSMSSubjectName = json['ISMS_SubjectName'];
    eSTMPSMaxMarks = json['ESTMPS_MaxMarks'];
    eSTMPSObtainedMarks = json['ESTMPS_ObtainedMarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    data['EME_ExamOrder'] = eMEExamOrder;
    data['ISMS_OrderFlag'] = iSMSOrderFlag;
    data['AMST_Id'] = aMSTId;
    data['ISMS_Id'] = iSMSId;
    data['EME_Id'] = eMEId;
    data['EME_ExamName'] = eMEExamName;
    data['ISMS_SubjectName'] = iSMSSubjectName;
    data['ESTMPS_MaxMarks'] = eSTMPSMaxMarks;
    data['ESTMPS_ObtainedMarks'] = eSTMPSObtainedMarks;
    return data;
  }
}
