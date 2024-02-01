class LeaveApprovePopUp {
  String? type;
  List<LeaveApprovePopUpValues>? values;

  LeaveApprovePopUp({this.type, this.values});

  LeaveApprovePopUp.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <LeaveApprovePopUpValues>[];
      json['\$values'].forEach((v) {
        values!.add(LeaveApprovePopUpValues.fromJson(v));
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

class LeaveApprovePopUpValues {
  String? type;
  String? hRMEEmployeeFirstName;
  int? hRELAPId;
  String? hRMLLeaveName;
  String? hRELAPFromDate;
  String? hRELAPToDate;
  double? hRELAPTotalDays;
  String? hRELAPReportingDate;
  String? hRELAPLeaveReason;
  int? hRMEId;
  int? hRMLId;
  String? hRELAPApplicationID;
  dynamic hRELAPSupportingDocument;
  dynamic hRELAPARemarks;
  String? hRELAPApplicationDate;

  LeaveApprovePopUpValues(
      {this.type,
      this.hRMEEmployeeFirstName,
      this.hRELAPId,
      this.hRMLLeaveName,
      this.hRELAPFromDate,
      this.hRELAPToDate,
      this.hRELAPTotalDays,
      this.hRELAPReportingDate,
      this.hRELAPLeaveReason,
      this.hRMEId,
      this.hRMLId,
      this.hRELAPApplicationID,
      this.hRELAPSupportingDocument,
      this.hRELAPARemarks,
      this.hRELAPApplicationDate});

  LeaveApprovePopUpValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEEmployeeFirstName = json['HRME_EmployeeFirstName'];
    hRELAPId = json['HRELAP_Id'];
    hRMLLeaveName = json['HRML_LeaveName'];
    hRELAPFromDate = json['HRELAP_FromDate'];
    hRELAPToDate = json['HRELAP_ToDate'];
    hRELAPTotalDays = json['HRELAP_TotalDays'];
    hRELAPReportingDate = json['HRELAP_ReportingDate'];
    hRELAPLeaveReason = json['HRELAP_LeaveReason'];
    hRMEId = json['HRME_Id'];
    hRMLId = json['HRML_Id'];
    hRELAPApplicationID = json['HRELAP_ApplicationID'];
    hRELAPSupportingDocument = json['HRELAP_SupportingDocument'];
    hRELAPARemarks = json['HRELAPA_Remarks'];
    hRELAPApplicationDate = json['HRELAP_ApplicationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_EmployeeFirstName'] = hRMEEmployeeFirstName;
    data['HRELAP_Id'] = hRELAPId;
    data['HRML_LeaveName'] = hRMLLeaveName;
    data['HRELAP_FromDate'] = hRELAPFromDate;
    data['HRELAP_ToDate'] = hRELAPToDate;
    data['HRELAP_TotalDays'] = hRELAPTotalDays;
    data['HRELAP_ReportingDate'] = hRELAPReportingDate;
    data['HRELAP_LeaveReason'] = hRELAPLeaveReason;
    data['HRME_Id'] = hRMEId;
    data['HRML_Id'] = hRMLId;
    data['HRELAP_ApplicationID'] = hRELAPApplicationID;
    data['HRELAP_SupportingDocument'] = hRELAPSupportingDocument;
    data['HRELAPA_Remarks'] = hRELAPARemarks;
    data['HRELAP_ApplicationDate'] = hRELAPApplicationDate;
    return data;
  }
}
