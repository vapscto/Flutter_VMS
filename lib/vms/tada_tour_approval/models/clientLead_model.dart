class LeadsModel {
  String? type;
  List<LeadsModelValues>? values;

  LeadsModel({this.type, this.values});

  LeadsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <LeadsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add( LeadsModelValues.fromJson(v));
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

class LeadsModelValues {
  String? type;
  int? iSMSLEId;
  String? iSMSLELeadName;
  int? iSMSLEStudentStrength;
  int? iSMSLEStaffStrength;
  int? iSMSMPRId;
  String? iSMSMPRProductName;
  String? sourceName;
  String? iVRMMSName;

  LeadsModelValues(
      {this.type,
      this.iSMSLEId,
      this.iSMSLELeadName,
      this.iSMSLEStudentStrength,
      this.iSMSLEStaffStrength,
      this.iSMSMPRId,
      this.iSMSMPRProductName,
      this.sourceName,
      this.iVRMMSName});

  LeadsModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMSLEId = json['ISMSLE_Id'];
    iSMSLELeadName = json['ISMSLE_LeadName'];
    iSMSLEStudentStrength = json['ISMSLE_StudentStrength'];
    iSMSLEStaffStrength = json['ISMSLE_StaffStrength'];
    iSMSMPRId = json['ISMSMPR_Id'];
    iSMSMPRProductName = json['ISMSMPR_ProductName'];
    sourceName = json['SourceName'];
    iVRMMSName = json['IVRMMS_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['ISMSLE_Id'] = this.iSMSLEId;
    data['ISMSLE_LeadName'] = this.iSMSLELeadName;
    data['ISMSLE_StudentStrength'] = this.iSMSLEStudentStrength;
    data['ISMSLE_StaffStrength'] = this.iSMSLEStaffStrength;
    data['ISMSMPR_Id'] = this.iSMSMPRId;
    data['ISMSMPR_ProductName'] = this.iSMSMPRProductName;
    data['SourceName'] = this.sourceName;
    data['IVRMMS_Name'] = this.iVRMMSName;
    return data;
  }
}
