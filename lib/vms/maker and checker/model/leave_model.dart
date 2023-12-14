class GetListLeaveModel {
  String? type;
  List<GetListLeaveModelValues>? values;

  GetListLeaveModel({this.type, this.values});

  GetListLeaveModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetListLeaveModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new GetListLeaveModelValues.fromJson(v));
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

class GetListLeaveModelValues {
  String? type;
  String? hRMEEmployeeFirstName;
  int? hRELAPId;
  String? hRMLLeaveName;
  String? hRELAPFromDate;
  String? hRELAPToDate;
  int? hRELAPTotalDays;
  String? hRELAPReportingDate;
  String? hRELAPLeaveReason;
  int? hRMEId;
  int? hRMLId;
  String? hRELAPApplicationID;
  String? hRELAPSupportingDocument;
  String? hRELAPARemarks;
  String? hRELAPApplicationDate;

  GetListLeaveModelValues(
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

  GetListLeaveModelValues.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['HRME_EmployeeFirstName'] = this.hRMEEmployeeFirstName;
    data['HRELAP_Id'] = this.hRELAPId;
    data['HRML_LeaveName'] = this.hRMLLeaveName;
    data['HRELAP_FromDate'] = this.hRELAPFromDate;
    data['HRELAP_ToDate'] = this.hRELAPToDate;
    data['HRELAP_TotalDays'] = this.hRELAPTotalDays;
    data['HRELAP_ReportingDate'] = this.hRELAPReportingDate;
    data['HRELAP_LeaveReason'] = this.hRELAPLeaveReason;
    data['HRME_Id'] = this.hRMEId;
    data['HRML_Id'] = this.hRMLId;
    data['HRELAP_ApplicationID'] = this.hRELAPApplicationID;
    data['HRELAP_SupportingDocument'] = this.hRELAPSupportingDocument;
    data['HRELAPA_Remarks'] = this.hRELAPARemarks;
    data['HRELAP_ApplicationDate'] = this.hRELAPApplicationDate;
    return data;
  }
}
