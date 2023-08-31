class AttendanceDetailModel {
  String? type;
  List<AttendanceDetailValues>? values;

  AttendanceDetailModel({this.type, this.values});

  AttendanceDetailModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AttendanceDetailValues>[];
      json['\$values'].forEach((v) {
        values!.add(AttendanceDetailValues.fromJson(v));
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

class AttendanceDetailValues {
  String? type;
  String? mONTHNAME;
  dynamic tOTALPRESENT;
  String? cLASSHELD;
  dynamic score;

  AttendanceDetailValues(
      {this.type,
      this.mONTHNAME,
      this.tOTALPRESENT,
      this.cLASSHELD,
      this.score});

  AttendanceDetailValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    mONTHNAME = json['MONTH_NAME'];
    tOTALPRESENT = json['TOTAL_PRESENT'];
    cLASSHELD = json['CLASS_HELD'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    data['MONTH_NAME'] = mONTHNAME;
    data['TOTAL_PRESENT'] = tOTALPRESENT;
    data['CLASS_HELD'] = cLASSHELD;
    data['score'] = score;
    return data;
  }
}
