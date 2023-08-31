class StaffCoeModel {
  String? type;
  List<StaffCoeModelValues>? values;

  StaffCoeModel({this.type, this.values});

  StaffCoeModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <StaffCoeModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(StaffCoeModelValues.fromJson(v));
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

class StaffCoeModelValues {
  String? eventName;
  String? eventDesc;
  String? coeEEStartDate;
  String? coeEEEndDate;

  String? coeeVVideos;
  String? coeeIImages;
  String? cOEEEEndTime;
  String? cOEEEStartTime;

  StaffCoeModelValues({
    this.eventName,
    this.eventDesc,
    this.coeEEStartDate,
    this.coeEEEndDate,
    this.cOEEEEndTime,
    this.cOEEEStartTime,
    this.coeeIImages,
    this.coeeVVideos,
  });

  StaffCoeModelValues.fromJson(Map<String, dynamic> json) {
    eventName = json['COEME_EventName'];
    eventDesc = json['COEME_EventDesc'];
    coeEEStartDate = json['COEE_EStartDate'];
    coeEEEndDate = json['COEE_EEndDate'];
    coeeIImages = json['COEEI_Images'];
    cOEEEEndTime = json['COEE_EEndTime'];
    cOEEEStartTime = json['COEE_EStartTime'];
    coeeVVideos = json['COEEV_Videos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['eventName'] = eventName;
    data['eventDesc'] = eventDesc;
    data['coeE_EStartDate'] = coeEEStartDate;
    data['coeE_EEndDate'] = coeEEEndDate;

    return data;
  }
}
