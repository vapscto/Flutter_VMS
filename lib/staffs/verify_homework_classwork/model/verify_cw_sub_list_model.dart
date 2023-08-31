class VerifyCwSubjectListModel {
  String? type;
  List<VerifyCwSubjectListModelValues>? values;

  VerifyCwSubjectListModel({this.type, this.values});

  VerifyCwSubjectListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <VerifyCwSubjectListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(VerifyCwSubjectListModelValues.fromJson(v));
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

class VerifyCwSubjectListModelValues {
  String? type;
  int? iSMSId;
  String? iSMSSubjectName;

  VerifyCwSubjectListModelValues(
      {this.type, this.iSMSId, this.iSMSSubjectName});

  VerifyCwSubjectListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMSId = json['ISMS_Id'];
    iSMSSubjectName = json['ISMS_SubjectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMS_Id'] = iSMSId;
    data['ISMS_SubjectName'] = iSMSSubjectName;
    return data;
  }
}
