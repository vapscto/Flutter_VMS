class HomeworkTopicModel {
  String? type;
  List<HomeworkTopicModelValues>? values;

  HomeworkTopicModel({this.type, this.values});

  HomeworkTopicModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <HomeworkTopicModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(HomeworkTopicModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeworkTopicModelValues {
  String? type;
  int? iHWId;
  String? iHWTopic;
  int? aSMAYId;
  int? aSMCLId;
  int? aSMSId;
  int? iVRMULId;
  String? iHWDate;
  int? iSMSId;

  HomeworkTopicModelValues(
      {this.type,
      this.iHWId,
      this.iHWTopic,
      this.aSMAYId,
      this.aSMCLId,
      this.aSMSId,
      this.iVRMULId,
      this.iHWDate,
      this.iSMSId});

  HomeworkTopicModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iHWId = json['IHW_Id'];
    iHWTopic = json['IHW_Topic'];
    aSMAYId = json['ASMAY_Id'];
    aSMCLId = json['ASMCL_Id'];
    aSMSId = json['ASMS_Id'];
    iVRMULId = json['IVRMUL_Id'];
    iHWDate = json['IHW_Date'];
    iSMSId = json['ISMS_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['IHW_Id'] = iHWId;
    data['IHW_Topic'] = iHWTopic;
    data['ASMAY_Id'] = aSMAYId;
    data['ASMCL_Id'] = aSMCLId;
    data['ASMS_Id'] = aSMSId;
    data['IVRMUL_Id'] = iVRMULId;
    data['IHW_Date'] = iHWDate;
    data['ISMS_Id'] = iSMSId;
    return data;
  }
}
