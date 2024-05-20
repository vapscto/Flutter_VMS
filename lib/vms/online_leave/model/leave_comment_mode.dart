class LeaveCommentModel {
  String? type;
  List<LeaveCommentModelValues>? values;

  LeaveCommentModel({this.type, this.values});

  LeaveCommentModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <LeaveCommentModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(LeaveCommentModelValues.fromJson(v));
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

class LeaveCommentModelValues {
  String? type;
  String? iVRMSTAULUserName;
  dynamic hRLAONSanctionLevelNo;
  String? hRELAPALeaveStatus;
  String? hRELAPARemarks;
  String? hRELAPAFromDate;
  String? hRELAPAToDate;
  double? hRELAPATotalDays;
  String? createdDate;
  String? hRELAPFromDate;
  String? hRELAPToDate;
  String? hRELAPSupportingDocument;
  String? updatedDate;

  LeaveCommentModelValues(
      {this.type,
      this.iVRMSTAULUserName,
      this.hRLAONSanctionLevelNo,
      this.hRELAPALeaveStatus,
      this.hRELAPARemarks,
      this.hRELAPAFromDate,
      this.hRELAPAToDate,
      this.hRELAPATotalDays,
      this.createdDate,
      this.hRELAPFromDate,
      this.hRELAPToDate,
      this.hRELAPSupportingDocument,
      this.updatedDate});

  LeaveCommentModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iVRMSTAULUserName = json['IVRMSTAUL_UserName'];
    hRLAONSanctionLevelNo = json['HRLAON_SanctionLevelNo'];
    hRELAPALeaveStatus = json['HRELAPA_LeaveStatus'];
    hRELAPARemarks = json['HRELAPA_Remarks'];
    hRELAPAFromDate = json['HRELAPA_FromDate'];
    hRELAPAToDate = json['HRELAPA_ToDate'];
    hRELAPATotalDays = json['HRELAPA_TotalDays'];
    createdDate = json['createdDate'];
    hRELAPFromDate = json['HRELAP_FromDate'];
    hRELAPToDate = json['HRELAP_ToDate'];
    hRELAPSupportingDocument = json['HRELAP_SupportingDocument'];
    updatedDate = json['UpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['IVRMSTAUL_UserName'] = iVRMSTAULUserName;
    data['HRLAON_SanctionLevelNo'] = hRLAONSanctionLevelNo;
    data['HRELAPA_LeaveStatus'] = hRELAPALeaveStatus;
    data['HRELAPA_Remarks'] = hRELAPARemarks;
    data['HRELAPA_FromDate'] = hRELAPAFromDate;
    data['HRELAPA_ToDate'] = hRELAPAToDate;
    data['HRELAPA_TotalDays'] = hRELAPATotalDays;
    data['createdDate'] = createdDate;
    data['HRELAP_FromDate'] = hRELAPFromDate;
    data['HRELAP_ToDate'] = hRELAPToDate;
    data['HRELAP_SupportingDocument'] = hRELAPSupportingDocument;
    data['UpdatedDate'] = updatedDate;
    return data;
  }
}
