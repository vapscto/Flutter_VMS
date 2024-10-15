class HealthCheckupDataModel {
  String? type;
  List<HealthCheckupDataModelValues>? values;

  HealthCheckupDataModel({this.type, this.values});

  HealthCheckupDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <HealthCheckupDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(HealthCheckupDataModelValues.fromJson(v));
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

class HealthCheckupDataModelValues {
  String? type;
  int? hWHCHUPId;
  int? iSMMCLTId;
  int? hRMEId;
  int? approvedLevel;
  int? finalFlag;
  String? hWHCHUPDate;
  String? hWHCHUPRemarks;
  String? hWHCHUPStauts;
  String? hRMEEmployeeFirstName;
  String? iSMMCLTClientName;
  int? filesCount;

  HealthCheckupDataModelValues(
      {this.type,
      this.hWHCHUPId,
      this.iSMMCLTId,
      this.hRMEId,
      this.approvedLevel,
      this.finalFlag,
      this.hWHCHUPDate,
      this.hWHCHUPRemarks,
      this.hWHCHUPStauts,
      this.hRMEEmployeeFirstName,
      this.iSMMCLTClientName,
      this.filesCount});

  HealthCheckupDataModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hWHCHUPId = json['HWHCHUP_Id'];
    iSMMCLTId = json['ISMMCLT_Id'];
    hRMEId = json['HRME_Id'];
    approvedLevel = json['Approved_Level'];
    finalFlag = json['FinalFlag'];
    hWHCHUPDate = json['HWHCHUP_Date'];
    hWHCHUPRemarks = json['HWHCHUP_Remarks'];
    hWHCHUPStauts = json['HWHCHUP_Stauts'];
    hRMEEmployeeFirstName = json['HRME_EmployeeFirstName'];
    iSMMCLTClientName = json['ISMMCLT_ClientName'];
    filesCount = json['FilesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HWHCHUP_Id'] = hWHCHUPId;
    data['ISMMCLT_Id'] = iSMMCLTId;
    data['HRME_Id'] = hRMEId;
    data['Approved_Level'] = approvedLevel;
    data['FinalFlag'] = finalFlag;
    data['HWHCHUP_Date'] = hWHCHUPDate;
    data['HWHCHUP_Remarks'] = hWHCHUPRemarks;
    data['HWHCHUP_Stauts'] = hWHCHUPStauts;
    data['HRME_EmployeeFirstName'] = hRMEEmployeeFirstName;
    data['ISMMCLT_ClientName'] = iSMMCLTClientName;
    data['FilesCount'] = filesCount;
    return data;
  }
}
