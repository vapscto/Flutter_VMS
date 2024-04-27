class TadaPlanerData {
  String? type;
  List<TadaPlanerDataValues>? values;

  TadaPlanerData({this.type, this.values});

  TadaPlanerData.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <TadaPlanerDataValues>[];
      json['\$values'].forEach((v) {
        values!.add(TadaPlanerDataValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TadaPlanerDataValues {
  String? type;
  int? iVRMMSId;
  int? iSMSLEId;
  String? iSMSLELeadName;
  int? iSMSLEStudentStrength;
  int? iSMSLEStaffStrength;
  String? iSMSMPRProductName;
  int? iSMSMPRId;
  String? sourceName;
  int? iMRCCategoryId;
  String? iMRCCategoryName;
  int? iERID;
  String? iVRMMSName;
  String? hRMEEmployeeFirstName;
  String? demoEmployeeFirstName;

  TadaPlanerDataValues(
      {this.type,
      this.iVRMMSId,
      this.iSMSLEId,
      this.iSMSLELeadName,
      this.iSMSLEStudentStrength,
      this.iSMSLEStaffStrength,
      this.iSMSMPRProductName,
      this.iSMSMPRId,
      this.sourceName,
      this.iMRCCategoryId,
      this.iMRCCategoryName,
      this.iERID,
      this.iVRMMSName,
      this.hRMEEmployeeFirstName,
      this.demoEmployeeFirstName});

  TadaPlanerDataValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iVRMMSId = json['IVRMMS_Id'];
    iSMSLEId = json['ISMSLE_Id'];
    iSMSLELeadName = json['ISMSLE_LeadName'];
    iSMSLEStudentStrength = json['ISMSLE_StudentStrength'];
    iSMSLEStaffStrength = json['ISMSLE_StaffStrength'];
    iSMSMPRProductName = json['ISMSMPR_ProductName'];
    iSMSMPRId = json['ISMSMPR_Id'];
    sourceName = json['SourceName'];
    iMRCCategoryId = json['IMRC_CategoryId'];
    iMRCCategoryName = json['IMRC_CategoryName'];
    iERID = json['IER_ID'];
    iVRMMSName = json['IVRMMS_Name'];
    hRMEEmployeeFirstName = json['HRME_EmployeeFirstName'] ?? "";
    demoEmployeeFirstName = json['Demo_EmployeeFirstName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['IVRMMS_Id'] = iVRMMSId;
    data['ISMSLE_Id'] = iSMSLEId;
    data['ISMSLE_LeadName'] = iSMSLELeadName;
    data['ISMSLE_StudentStrength'] = iSMSLEStudentStrength;
    data['ISMSLE_StaffStrength'] = iSMSLEStaffStrength;
    data['ISMSMPR_ProductName'] = iSMSMPRProductName;
    data['ISMSMPR_Id'] = iSMSMPRId;
    data['SourceName'] = sourceName;
    data['IMRC_CategoryId'] = iMRCCategoryId;
    data['IMRC_CategoryName'] = iMRCCategoryName;
    data['IER_ID'] = iERID;
    data['IVRMMS_Name'] = iVRMMSName;
    data['HRME_EmployeeFirstName'] = hRMEEmployeeFirstName;
    data['Demo_EmployeeFirstName'] = demoEmployeeFirstName;
    return data;
  }
}
