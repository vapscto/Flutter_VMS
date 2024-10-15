class GetLoadedDataModel {
  String? type;
  List<GetLoadedDataModelValues>? values;

  GetLoadedDataModel({this.type, this.values});

  GetLoadedDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetLoadedDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetLoadedDataModelValues.fromJson(v));
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

class GetLoadedDataModelValues {
  String? type;
  int? hWHCHUPId;
  int? iSMMCLTId;
  int? hRMEId;
  String? overAllStatus;
  String? approvedStatus;
  String? approvedDate;
  String? appliedDate;
  String? hRMEEmployeeFirstName;
  String? iSMMCLTClientName;

  GetLoadedDataModelValues(
      {this.type,
      this.hWHCHUPId,
      this.iSMMCLTId,
      this.hRMEId,
      this.overAllStatus,
      this.approvedStatus,
      this.approvedDate,
      this.appliedDate,
      this.hRMEEmployeeFirstName,
      this.iSMMCLTClientName});

  GetLoadedDataModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hWHCHUPId = json['HWHCHUP_Id'];
    iSMMCLTId = json['ISMMCLT_Id'];
    hRMEId = json['HRME_Id'];
    overAllStatus = json['OverAllStatus'];
    approvedStatus = json['ApprovedStatus'];
    approvedDate = json['ApprovedDate'];
    appliedDate = json['AppliedDate'];
    hRMEEmployeeFirstName = json['HRME_EmployeeFirstName'];
    iSMMCLTClientName = json['ISMMCLT_ClientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HWHCHUP_Id'] = hWHCHUPId;
    data['ISMMCLT_Id'] = iSMMCLTId;
    data['HRME_Id'] = hRMEId;
    data['OverAllStatus'] = overAllStatus;
    data['ApprovedStatus'] = approvedStatus;
    data['ApprovedDate'] = approvedDate;
    data['AppliedDate'] = appliedDate;
    data['HRME_EmployeeFirstName'] = hRMEEmployeeFirstName;
    data['ISMMCLT_ClientName'] = iSMMCLTClientName;
    return data;
  }
}
