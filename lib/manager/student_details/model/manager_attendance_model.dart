class ManagerAttendanceModel {
  String? type;
  List<ManagerAttendanceModelValues>? values;

  ManagerAttendanceModel({this.type, this.values});

  ManagerAttendanceModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ManagerAttendanceModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ManagerAttendanceModelValues.fromJson(v));
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

class ManagerAttendanceModelValues {
  String? type;
  String? mONTHNAME;
  double? tOTALPRESENT;
  String? cLASSHELD;
  double? score;

  ManagerAttendanceModelValues(
      {this.type,
      this.mONTHNAME,
      this.tOTALPRESENT,
      this.cLASSHELD,
      this.score});

  ManagerAttendanceModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    mONTHNAME = json['MONTH_NAME'];
    tOTALPRESENT = json['TOTAL_PRESENT'];
    cLASSHELD = json['CLASS_HELD'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['MONTH_NAME'] = mONTHNAME;
    data['TOTAL_PRESENT'] = tOTALPRESENT;
    data['CLASS_HELD'] = cLASSHELD;
    data['score'] = score;
    return data;
  }
}
