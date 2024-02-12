class QRcodeActivityDetails {
  String? type;
  List<QRcodeActivityDetailsValues>? values;

  QRcodeActivityDetails({this.type, this.values});

  QRcodeActivityDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <QRcodeActivityDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(QRcodeActivityDetailsValues.fromJson(v));
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

class QRcodeActivityDetailsValues {
  String? type;
  int? id;
  String? hRMBBuildingName;
  String? hRMFFloorName;
  int? hRMARId;
  int? hRMARACTId;
  int? hRMARACTTId;
  String? hRMARAreaName;
  String? hRMARACTActivityName;
  String? hRMARACTTTime;
  int? hRMARACTTActivityDuration;
  String? userName;
  String? hRMARACTSTMAPDate;

  QRcodeActivityDetailsValues(
      {this.type,
      this.id,
      this.hRMBBuildingName,
      this.hRMFFloorName,
      this.hRMARId,
      this.hRMARACTId,
      this.hRMARACTTId,
      this.hRMARAreaName,
      this.hRMARACTActivityName,
      this.hRMARACTTTime,
      this.hRMARACTTActivityDuration,
      this.userName,
      this.hRMARACTSTMAPDate});

  QRcodeActivityDetailsValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    id = json['Id'];
    hRMBBuildingName = json['HRMB_BuildingName'];
    hRMFFloorName = json['HRMF_FloorName'];
    hRMARId = json['HRMAR_Id'];
    hRMARACTId = json['HRMARACT_Id'];
    hRMARACTTId = json['HRMARACTT_Id'];
    hRMARAreaName = json['HRMAR_AreaName'];
    hRMARACTActivityName = json['HRMARACT_ActivityName'];
    hRMARACTTTime = json['HRMARACTT_Time'];
    hRMARACTTActivityDuration = json['HRMARACTT_ActivityDuration'];
    userName = json['UserName'];
    hRMARACTSTMAPDate = json['HRMARACTSTMAP_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['Id'] = id;
    data['HRMB_BuildingName'] = hRMBBuildingName;
    data['HRMF_FloorName'] = hRMFFloorName;
    data['HRMAR_Id'] = hRMARId;
    data['HRMARACT_Id'] = hRMARACTId;
    data['HRMARACTT_Id'] = hRMARACTTId;
    data['HRMAR_AreaName'] = hRMARAreaName;
    data['HRMARACT_ActivityName'] = hRMARACTActivityName;
    data['HRMARACTT_Time'] = hRMARACTTTime;
    data['HRMARACTT_ActivityDuration'] = hRMARACTTActivityDuration;
    data['UserName'] = userName;
    data['HRMARACTSTMAP_Date'] = hRMARACTSTMAPDate;
    return data;
  }
}
