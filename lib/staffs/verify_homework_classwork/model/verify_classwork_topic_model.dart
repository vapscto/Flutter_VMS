class ClassworkTopicModel {
  String? type;
  List<ClassworkTopicModelValues>? values;

  ClassworkTopicModel({this.type, this.values});

  ClassworkTopicModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ClassworkTopicModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ClassworkTopicModelValues.fromJson(v));
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

class ClassworkTopicModelValues {
  String? type;
  int? iCWId;
  String? iCWTopic;
  int? aSMAYId;
  int? aSMCLId;
  int? aSMSId;
  int? loginId;
  String? iCWFromDate;
  String? iCWToDate;
  int? iSMSId;

  ClassworkTopicModelValues(
      {this.type,
      this.iCWId,
      this.iCWTopic,
      this.aSMAYId,
      this.aSMCLId,
      this.aSMSId,
      this.loginId,
      this.iCWFromDate,
      this.iCWToDate,
      this.iSMSId});

  ClassworkTopicModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iCWId = json['ICW_Id'];
    iCWTopic = json['ICW_Topic'];
    aSMAYId = json['ASMAY_Id'];
    aSMCLId = json['ASMCL_Id'];
    aSMSId = json['ASMS_Id'];
    loginId = json['Login_Id'];
    iCWFromDate = json['ICW_FromDate'];
    iCWToDate = json['ICW_ToDate'];
    iSMSId = json['ISMS_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ICW_Id'] = iCWId;
    data['ICW_Topic'] = iCWTopic;
    data['ASMAY_Id'] = aSMAYId;
    data['ASMCL_Id'] = aSMCLId;
    data['ASMS_Id'] = aSMSId;
    data['Login_Id'] = loginId;
    data['ICW_FromDate'] = iCWFromDate;
    data['ICW_ToDate'] = iCWToDate;
    data['ISMS_Id'] = iSMSId;
    return data;
  }
}
