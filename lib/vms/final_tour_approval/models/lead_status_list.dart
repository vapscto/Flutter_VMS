class LeadStatusNameModel {
  String? type;
  List<LeadStatusNameModelValues>? values;

  LeadStatusNameModel({this.type, this.values});

  LeadStatusNameModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <LeadStatusNameModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new LeadStatusNameModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['IER_ID'] = this.iERID;
    data['IER_EmpId'] = this.iEREmpId;
    data['IERCLE_Id'] = this.iERCLEId;
    data['ISMSLE_LeadName'] = this.iSMSLELeadName;
    data['ISMSMSO_SourceName'] = this.iSMSMSOSourceName;
    data['ISMSMPR_Id'] = this.iSMSMPRId;
    data['ISMSMPR_ProductName'] = this.iSMSMPRProductName;
    data['IMRC_CategoryId'] = this.iMRCCategoryId;
    data['IMRC_CategoryName'] = this.iMRCCategoryName;
    data['IVRMMS_Id'] = this.iVRMMSId;
    data['IVRMMS_Name'] = this.iVRMMSName;
    data['LeadStatus'] = this.leadStatus;
    data['TotalCost'] = this.totalCost;
    data['HRME_EmployeeFirstName'] = this.hRMEEmployeeFirstName;
    data['Demo_EmployeeFirstName'] = this.demoEmployeeFirstName;
    return data;
  }
}
