class TopExamListModel {
  String? type;
  List<TopExamListModelValues>? values;

  TopExamListModel({this.type, this.values});

  TopExamListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TopExamListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new TopExamListModelValues.fromJson(v));
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

class TopExamListModelValues {
  int? emEId;
  int? mIId;
  String? emEExamName;
  String? emEExamCode;
  String? emEIVRSExamName;
  int? emEExamOrder;
  bool? emEFinalExamFlag;
  bool? emEActiveFlag;
  String? createdDate;
  String? updatedDate;
  String? emEExamDescription;

  TopExamListModelValues(
      {this.emEId,
      this.mIId,
      this.emEExamName,
      this.emEExamCode,
      this.emEIVRSExamName,
      this.emEExamOrder,
      this.emEFinalExamFlag,
      this.emEActiveFlag,
      this.createdDate,
      this.updatedDate,
      this.emEExamDescription});

  TopExamListModelValues.fromJson(Map<String, dynamic> json) {
    emEId = json['emE_Id'];
    mIId = json['mI_Id'];
    emEExamName = json['emE_ExamName'];
    emEExamCode = json['emE_ExamCode'];
    emEIVRSExamName = json['emE_IVRSExamName'];
    emEExamOrder = json['emE_ExamOrder'];
    emEFinalExamFlag = json['emE_FinalExamFlag'];
    emEActiveFlag = json['emE_ActiveFlag'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    emEExamDescription = json['emE_ExamDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emE_Id'] = this.emEId;
    data['mI_Id'] = this.mIId;
    data['emE_ExamName'] = this.emEExamName;
    data['emE_ExamCode'] = this.emEExamCode;
    data['emE_IVRSExamName'] = this.emEIVRSExamName;
    data['emE_ExamOrder'] = this.emEExamOrder;
    data['emE_FinalExamFlag'] = this.emEFinalExamFlag;
    data['emE_ActiveFlag'] = this.emEActiveFlag;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['emE_ExamDescription'] = this.emEExamDescription;
    return data;
  }
}
