// ignore: file_names
class CloseTaskCoutnModel {
  String? type;
  List<CloseTaskCoutnModelValues>? values;

  CloseTaskCoutnModel({this.type, this.values});

  CloseTaskCoutnModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CloseTaskCoutnModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CloseTaskCoutnModelValues.fromJson(v));
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

class CloseTaskCoutnModelValues {
  String? type;
  int? iSMEDWTCCTaskCount;

  CloseTaskCoutnModelValues({this.type, this.iSMEDWTCCTaskCount});

  CloseTaskCoutnModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    iSMEDWTCCTaskCount = json['ISMEDWTCC_TaskCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    data['ISMEDWTCC_TaskCount'] = iSMEDWTCCTaskCount;
    return data;
  }
}
