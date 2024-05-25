class LeadStatusNameModel {
  String? type;
  List<LeadStatusNameModelValues>? values;

  LeadStatusNameModel({this.type, this.values});

  LeadStatusNameModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <LeadStatusNameModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(LeadStatusNameModelValues.fromJson(v));
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

class LeadStatusNameModelValues {
  String? type;
  int? iERID;
  int? iEREmpId;
  int? iERCLEId;
  String? iSMSLELeadName;
  String? iSMSMSOSourceName;
  int? iSMSMPRId;
  String? iSMSMPRProductName;
  int? iMRCCategoryId;
  String? iMRCCategoryName;
  int? iVRMMSId;
  String? iVRMMSName;
  String? leadStatus;
  double? totalCost;
  String? hRMEEmployeeFirstName;
  String? demoEmployeeFirstName;

  LeadStatusNameModelValues(
      {this.type,
      this.iERID,
      this.iEREmpId,
      this.iERCLEId,
      this.iSMSLELeadName,
      this.iSMSMSOSourceName,
      this.iSMSMPRId,
      this.iSMSMPRProductName,
      this.iMRCCategoryId,
      this.iMRCCategoryName,
      this.iVRMMSId,
      this.iVRMMSName,
      this.leadStatus,
      this.totalCost,
      this.hRMEEmployeeFirstName,
      this.demoEmployeeFirstName});

  LeadStatusNameModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iERID = json['IER_ID'];
    iEREmpId = json['IER_EmpId'];
    iERCLEId = json['IERCLE_Id'];
    iSMSLELeadName = json['ISMSLE_LeadName'];
    iSMSMSOSourceName = json['ISMSMSO_SourceName'];
    iSMSMPRId = json['ISMSMPR_Id'];
    iSMSMPRProductName = json['ISMSMPR_ProductName'];
    iMRCCategoryId = json['IMRC_CategoryId'];
    iMRCCategoryName = json['IMRC_CategoryName'];
    iVRMMSId = json['IVRMMS_Id'];
    iVRMMSName = json['IVRMMS_Name'];
    leadStatus = json['LeadStatus'];
    totalCost = json['TotalCost'];
    hRMEEmployeeFirstName = json['HRME_EmployeeFirstName'];
    demoEmployeeFirstName = json['Demo_EmployeeFirstName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['IER_ID'] = iERID;
    data['IER_EmpId'] = iEREmpId;
    data['IERCLE_Id'] = iERCLEId;
    data['ISMSLE_LeadName'] = iSMSLELeadName;
    data['ISMSMSO_SourceName'] = iSMSMSOSourceName;
    data['ISMSMPR_Id'] = iSMSMPRId;
    data['ISMSMPR_ProductName'] = iSMSMPRProductName;
    data['IMRC_CategoryId'] = iMRCCategoryId;
    data['IMRC_CategoryName'] = iMRCCategoryName;
    data['IVRMMS_Id'] = iVRMMSId;
    data['IVRMMS_Name'] = iVRMMSName;
    data['LeadStatus'] = leadStatus;
    data['TotalCost'] = totalCost;
    data['HRME_EmployeeFirstName'] = hRMEEmployeeFirstName;
    data['Demo_EmployeeFirstName'] = demoEmployeeFirstName;
    return data;
  }
}
