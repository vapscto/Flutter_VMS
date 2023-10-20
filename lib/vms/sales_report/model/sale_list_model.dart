class SalesEmployeeListModel {
  String? type;
  List<SalesEmployeeListModelValues>? values;

  SalesEmployeeListModel({this.type, this.values});

  SalesEmployeeListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <SalesEmployeeListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(SalesEmployeeListModelValues.fromJson(v));
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

class SalesEmployeeListModelValues {
  String? type;
  int? hRMEId;
  String? iSMSLELeadName;
  String? iSMSLEVisitedDate;
  String? iSMSLEContactPerson;
  String? iSMSMPRProductName;
  String? hRMEEmployeeFirstName;
  String? iSMSMSTStatusName;
  String? iSMSLEDMDemoType;
  String? iSMSLEDMDemoDate;
  String? givenflg;

  SalesEmployeeListModelValues(
      {this.type,
      this.hRMEId,
      this.iSMSLELeadName,
      this.iSMSLEVisitedDate,
      this.iSMSLEContactPerson,
      this.iSMSMPRProductName,
      this.hRMEEmployeeFirstName,
      this.iSMSMSTStatusName,
      this.iSMSLEDMDemoType,
      this.iSMSLEDMDemoDate,
      this.givenflg});

  SalesEmployeeListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    iSMSLELeadName = json['ISMSLE_LeadName'];
    iSMSLEVisitedDate = json['ISMSLE_VisitedDate'];
    iSMSLEContactPerson = json['ISMSLE_ContactPerson'];
    iSMSMPRProductName = json['ISMSMPR_ProductName'];
    hRMEEmployeeFirstName = json['HRME_EmployeeFirstName'];
    iSMSMSTStatusName = json['ISMSMST_StatusName'];
    iSMSLEDMDemoType = json['ISMSLEDM_DemoType'];
    iSMSLEDMDemoDate = json['ISMSLEDM_DemoDate'];
    givenflg = json['givenflg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['ISMSLE_LeadName'] = iSMSLELeadName;
    data['ISMSLE_VisitedDate'] = iSMSLEVisitedDate;
    data['ISMSLE_ContactPerson'] = iSMSLEContactPerson;
    data['ISMSMPR_ProductName'] = iSMSMPRProductName;
    data['HRME_EmployeeFirstName'] = hRMEEmployeeFirstName;
    data['ISMSMST_StatusName'] = iSMSMSTStatusName;
    data['ISMSLEDM_DemoType'] = iSMSLEDMDemoType;
    data['ISMSLEDM_DemoDate'] = iSMSLEDMDemoDate;
    data['givenflg'] = givenflg;
    return data;
  }
}
