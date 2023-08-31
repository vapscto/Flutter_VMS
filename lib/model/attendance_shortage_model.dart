class AttendanceShortageModel {
  String? type;
  List<AttendanceShortageModelValues>? values;

  AttendanceShortageModel({this.type, this.values});

  AttendanceShortageModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AttendanceShortageModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(AttendanceShortageModelValues.fromJson(v));
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

class AttendanceShortageModelValues {
  String? type;
  double? per;

  AttendanceShortageModelValues({this.type, this.per});

  AttendanceShortageModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    per = json['per'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['per'] = per;
    return data;
  }
}
