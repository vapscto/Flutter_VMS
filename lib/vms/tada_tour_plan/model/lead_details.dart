class LeadCilent {
  String? type;
  List<LeadCilentValues>? values;

  LeadCilent({this.type, this.values});

  LeadCilent.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <LeadCilentValues>[];
      json['\$values'].forEach((v) {
        values!.add(LeadCilentValues.fromJson(v));
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

class LeadCilentValues {
  String? type;
  int? iVRMMSId;
  int? iSMSLEId;
  String? iSMSLELeadName;
  int? iSMSLEStudentStrength;
  int? iSMSLEStaffStrength;
  String? iSMSMPRProductName;
  int? iSMSMPRId;
  String? sourceName;
  String? iVRMMSName;
  int? iMRCCategoryId;
  String? iMRCCategoryName;
  int? iERID;
  int? iercleId;

  LeadCilentValues(
      {this.type,
      this.iVRMMSId,
      this.iSMSLEId,
      this.iSMSLELeadName,
      this.iSMSLEStudentStrength,
      this.iSMSLEStaffStrength,
      this.iSMSMPRProductName,
      this.iSMSMPRId,
      this.sourceName,
      this.iVRMMSName,
      this.iMRCCategoryId,
      this.iMRCCategoryName,
      this.iERID,
      this.iercleId});

  LeadCilentValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iVRMMSId = json['IVRMMS_Id'];
    iSMSLEId = json['ISMSLE_Id'];
    iSMSLELeadName = json['ISMSLE_LeadName'];
    iSMSLEStudentStrength = json['ISMSLE_StudentStrength'];
    iSMSLEStaffStrength = json['ISMSLE_StaffStrength'];
    iSMSMPRProductName = json['ISMSMPR_ProductName'];
    iSMSMPRId = json['ISMSMPR_Id'];
    sourceName = json['SourceName'];
    iVRMMSName = json['IVRMMS_Name'];
    iMRCCategoryId = json['IMRC_CategoryId'];
    iMRCCategoryName = json['IMRC_CategoryName'];
    iERID = json['IER_ID'];
    iercleId =json['IERCLE_Id'];
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
    data['IVRMMS_Name'] = iVRMMSName;
    data['IMRC_CategoryId'] = iMRCCategoryId;
    data['IMRC_CategoryName'] = iMRCCategoryName;
    data['IER_ID'] = iERID;
    data['IERCLE_Id']=iercleId;
    return data;
  }
}
