class CompletedTaskCountModel {
  String? type;
  List<CompletedTaskCountModelValues>? values;

  CompletedTaskCountModel({this.type, this.values});

  CompletedTaskCountModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CompletedTaskCountModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CompletedTaskCountModelValues.fromJson(v));
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

class CompletedTaskCountModelValues {
  String? type;
  int? iSMEDWTCCTaskCount;

  CompletedTaskCountModelValues({this.type, this.iSMEDWTCCTaskCount});

  CompletedTaskCountModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMEDWTCCTaskCount = json['ISMEDWTCC_TaskCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMEDWTCC_TaskCount'] = iSMEDWTCCTaskCount;
    return data;
  }
}
