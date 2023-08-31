class CoeDataModel {
  String? type;
  List<CoeDataModelValues>? values;

  CoeDataModel({this.type, this.values});

  CoeDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CoeDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CoeDataModelValues.fromJson(v));
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

class CoeDataModelValues {
  String? type;
  String? cOEMEEventName;
  String? cOEMEEventDesc;
  String? cOEEEStartDate;
  String? cOEEEEndDate;
  String? cOEEIImages;
  String? cOEEEEndTime;
  String? cOEEEStartTime;
  String? cOEEVVideos;

  CoeDataModelValues(
      {this.type,
      this.cOEMEEventName,
      this.cOEMEEventDesc,
      this.cOEEEStartDate,
      this.cOEEEEndDate,
      this.cOEEIImages,
      this.cOEEEEndTime,
      this.cOEEEStartTime,
      this.cOEEVVideos});

  CoeDataModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    cOEMEEventName = json['COEME_EventName'];
    cOEMEEventDesc = json['COEME_EventDesc'];
    cOEEEStartDate = json['COEE_EStartDate'];
    cOEEEEndDate = json['COEE_EEndDate'];
    cOEEIImages = json['COEEI_Images'];
    cOEEEEndTime = json['COEE_EEndTime'];
    cOEEEStartTime = json['COEE_EStartTime'];
    cOEEVVideos = json['COEEV_Videos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    data['COEME_EventName'] = cOEMEEventName;
    data['COEME_EventDesc'] = cOEMEEventDesc;
    data['COEE_EStartDate'] = cOEEEStartDate;
    data['COEE_EEndDate'] = cOEEEEndDate;
    data['COEEI_Images'] = cOEEIImages;
    data['COEE_EEndTime'] = cOEEEEndTime;
    data['COEE_EStartTime'] = cOEEEStartTime;
    data['COEEV_Videos'] = cOEEVVideos;
    return data;
  }
}
