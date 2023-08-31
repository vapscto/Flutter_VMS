class DashboardCoeDataModel {
  String? type;
  List<DashboardCoeDataModelValues>? values;

  DashboardCoeDataModel({this.type, this.values});

  DashboardCoeDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DashboardCoeDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DashboardCoeDataModelValues.fromJson(v));
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

class DashboardCoeDataModelValues {
  String? type;
  String? cOEMEEventName;
  String? cOEMEEventDesc;
  String? cOEEEStartDate;
  String? cOEEEEndDate;
  String? cOEEIImages;
  String? cOEEEEndTime;
  String? cOEEEStartTime;

  DashboardCoeDataModelValues(
      {this.type,
      this.cOEMEEventName,
      this.cOEMEEventDesc,
      this.cOEEEStartDate,
      this.cOEEEEndDate,
      this.cOEEIImages,
      this.cOEEEEndTime,
      this.cOEEEStartTime});

  DashboardCoeDataModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    cOEMEEventName = json['COEME_EventName'];
    cOEMEEventDesc = json['COEME_EventDesc'];
    cOEEEStartDate = json['COEE_EStartDate'];
    cOEEEEndDate = json['COEE_EEndDate'];
    cOEEIImages = json['COEEI_Images'];
    cOEEEEndTime = json['COEE_EEndTime'];
    cOEEEStartTime = json['COEE_EStartTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['COEME_EventName'] = cOEMEEventName;
    data['COEME_EventDesc'] = cOEMEEventDesc;
    data['COEE_EStartDate'] = cOEEEStartDate;
    data['COEE_EEndDate'] = cOEEEEndDate;
    data['COEEI_Images'] = cOEEIImages;
    data['COEE_EEndTime'] = cOEEEEndTime;
    data['COEE_EStartTime'] = cOEEEStartTime;
    return data;
  }
}
