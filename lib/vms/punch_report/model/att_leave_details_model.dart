class AttLeaveDetailsModel {
  String? type;
  List<Values>? values;

  AttLeaveDetailsModel({this.type, this.values});

  AttLeaveDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <Values>[];
      json['\$values'].forEach((v) {
        values!.add(Values.fromJson(v));
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

class Values {
  String? type;
  int? hRMEId;
  String? drNotSentDates;
  dynamic absentday;
  dynamic approvedday;

  Values(
      {this.type,
      this.hRMEId,
      this.drNotSentDates,
      this.absentday,
      this.approvedday});

  Values.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    drNotSentDates = json['DrNotSentDates'];
    absentday = json['Absentday'];
    approvedday = json['Approvedday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['DrNotSentDates'] = drNotSentDates;
    data['Absentday'] = absentday;
    data['Approvedday'] = approvedday;
    return data;
  }
}
