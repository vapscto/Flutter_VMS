class LeadListModel {
  String? type;
  List<LeadListModelValues>? values;

  LeadListModel({this.type, this.values});

  LeadListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <LeadListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(LeadListModelValues.fromJson(v));
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

class LeadListModelValues {
  String? type;
  int? iSMSLEId;
  String? iSMSLELeadName;

  LeadListModelValues({this.type, this.iSMSLEId, this.iSMSLELeadName});

  LeadListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMSLEId = json['ISMSLE_Id'];
    iSMSLELeadName = json['ISMSLE_LeadName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMSLE_Id'] = iSMSLEId;
    data['ISMSLE_LeadName'] = iSMSLELeadName;
    return data;
  }
}
