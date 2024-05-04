class AttLeaveNameModel {
  String? type;
  List<AttLeaveNameModelValues>? values;

  AttLeaveNameModel({this.type, this.values});

  AttLeaveNameModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AttLeaveNameModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(AttLeaveNameModelValues.fromJson(v));
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

class AttLeaveNameModelValues {
  String? type;
  int? hRMEId;
  String? drNotSentDates;
  dynamic absentday;
  dynamic approvedday;
  String? leavename;
  bool? lopadjest;

  AttLeaveNameModelValues(
      {this.type,
      this.hRMEId,
      this.drNotSentDates,
      this.absentday,
      this.approvedday,
      this.leavename,
      this.lopadjest});

  AttLeaveNameModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    drNotSentDates = json['DrNotSentDates'];
    absentday = json['Absentday'];
    approvedday = json['Approvedday'];
    leavename = json['leavename'];
    lopadjest = json['lopadjest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['DrNotSentDates'] = drNotSentDates;
    data['Absentday'] = absentday;
    data['Approvedday'] = approvedday;
    data['leavename'] = leavename;
    data['lopadjest'] = lopadjest;
    return data;
  }
}
