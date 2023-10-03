class PlannerStatusListModel {
  String? type;
  List<PlannerStatusListModelValues>? values;

  PlannerStatusListModel({this.type, this.values});

  PlannerStatusListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PlannerStatusListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(PlannerStatusListModelValues.fromJson(v));
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

class PlannerStatusListModelValues {
  String? type;
  int? iSMTPLId;
  int? hRMEId;
  int? iSMTPLPlannedBy;
  String? iSMTPLPlannerName;
  String? iSMTPLRemarks;
  String? iSMTPLStartDate;
  String? iSMTPLEndDate;
  double? iSMTPLTotalHrs;
  int? iSMTPLApprovedBy;
  bool? iSMTPLActiveFlg;
  String? planDate;
  bool? iSMTPLApprovalFlg;
  String? plannedby;
  String? approvedby;
  String? iSMTPLAPRemarks;

  PlannerStatusListModelValues(
      {this.type,
      this.iSMTPLId,
      this.hRMEId,
      this.iSMTPLPlannedBy,
      this.iSMTPLPlannerName,
      this.iSMTPLRemarks,
      this.iSMTPLStartDate,
      this.iSMTPLEndDate,
      this.iSMTPLTotalHrs,
      this.iSMTPLApprovedBy,
      this.iSMTPLActiveFlg,
      this.planDate,
      this.iSMTPLApprovalFlg,
      this.plannedby,
      this.approvedby,
      this.iSMTPLAPRemarks});

  PlannerStatusListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMTPLId = json['ISMTPL_Id'];
    hRMEId = json['HRME_Id'];
    iSMTPLPlannedBy = json['ISMTPL_PlannedBy'];
    iSMTPLPlannerName = json['ISMTPL_PlannerName'];
    iSMTPLRemarks = json['ISMTPL_Remarks'];
    iSMTPLStartDate = json['ISMTPL_StartDate'];
    iSMTPLEndDate = json['ISMTPL_EndDate'];
    iSMTPLTotalHrs = json['ISMTPL_TotalHrs'];
    iSMTPLApprovedBy = json['ISMTPL_ApprovedBy'];
    iSMTPLActiveFlg = json['ISMTPL_ActiveFlg'];
    planDate = json['planDate'];
    iSMTPLApprovalFlg = json['ISMTPL_ApprovalFlg'];
    plannedby = json['plannedby'];
    approvedby = json['approvedby'];
    iSMTPLAPRemarks = json['ISMTPLAP_Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMTPL_Id'] = iSMTPLId;
    data['HRME_Id'] = hRMEId;
    data['ISMTPL_PlannedBy'] = iSMTPLPlannedBy;
    data['ISMTPL_PlannerName'] = iSMTPLPlannerName;
    data['ISMTPL_Remarks'] = iSMTPLRemarks;
    data['ISMTPL_StartDate'] = iSMTPLStartDate;
    data['ISMTPL_EndDate'] = iSMTPLEndDate;
    data['ISMTPL_TotalHrs'] = iSMTPLTotalHrs;
    data['ISMTPL_ApprovedBy'] = iSMTPLApprovedBy;
    data['ISMTPL_ActiveFlg'] = iSMTPLActiveFlg;
    data['planDate'] = planDate;
    data['ISMTPL_ApprovalFlg'] = iSMTPLApprovalFlg;
    data['plannedby'] = plannedby;
    data['approvedby'] = approvedby;
    data['ISMTPLAP_Remarks'] = iSMTPLAPRemarks;
    return data;
  }
}
