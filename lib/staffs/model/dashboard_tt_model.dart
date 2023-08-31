class StaffDashboardTimetableModel {
  String? type;
  List<StaffDashboardTimetableModelValues>? values;

  StaffDashboardTimetableModel({this.type, this.values});

  StaffDashboardTimetableModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <StaffDashboardTimetableModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(StaffDashboardTimetableModelValues.fromJson(v));
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

class StaffDashboardTimetableModelValues {
  String? type;
  String? tTMDDayName;
  String? tTMDDayCode;
  String? iSMSSubjectName;
  String? tTMSUABAbbreviation;
  String? tTMDPTStartTime;
  String? tTMDPTEndTime;
  String? classsection;
  StaffDashboardTimetableModelValues(
      {this.type,
      this.tTMDDayName,
      this.tTMDDayCode,
      this.iSMSSubjectName,
      this.tTMSUABAbbreviation,
      this.tTMDPTStartTime,
      this.tTMDPTEndTime,
      this.classsection});

  StaffDashboardTimetableModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    tTMDDayName = json['TTMD_DayName'];
    tTMDDayCode = json['TTMD_DayCode'];
    iSMSSubjectName = json['ISMS_SubjectName'];
    tTMSUABAbbreviation = json['TTMSUAB_Abbreviation'];
    tTMDPTStartTime = json['TTMDPT_StartTime'];
    tTMDPTEndTime = json['TTMDPT_EndTime'];
    classsection = json['classsection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['TTMD_DayName'] = tTMDDayName;
    data['TTMD_DayCode'] = tTMDDayCode;
    data['ISMS_SubjectName'] = iSMSSubjectName;
    data['TTMSUAB_Abbreviation'] = tTMSUABAbbreviation;
    data['TTMDPT_StartTime'] = tTMDPTStartTime;
    data['TTMDPT_EndTime'] = tTMDPTEndTime;
    data['classsection'] = classsection;
    return data;
  }
}
