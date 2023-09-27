class qRcodeActivityDetails {
  String? type;
  List<qRcodeActivityDetailsValues>? values;

  qRcodeActivityDetails({this.type, this.values});

  qRcodeActivityDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <qRcodeActivityDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(  qRcodeActivityDetailsValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class qRcodeActivityDetailsValues {
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

  qRcodeActivityDetailsValues(
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

  qRcodeActivityDetailsValues.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['Id'] = this.id;
    data['HRMB_BuildingName'] = this.hRMBBuildingName;
    data['HRMF_FloorName'] = this.hRMFFloorName;
    data['HRMAR_Id'] = this.hRMARId;
    data['HRMARACT_Id'] = this.hRMARACTId;
    data['HRMARACTT_Id'] = this.hRMARACTTId;
    data['HRMAR_AreaName'] = this.hRMARAreaName;
    data['HRMARACT_ActivityName'] = this.hRMARACTActivityName;
    data['HRMARACTT_Time'] = this.hRMARACTTTime;
    data['HRMARACTT_ActivityDuration'] = this.hRMARACTTActivityDuration;
    data['UserName'] = this.userName;
    data['HRMARACTSTMAP_Date'] = this.hRMARACTSTMAPDate;
    return data;
  }
}

