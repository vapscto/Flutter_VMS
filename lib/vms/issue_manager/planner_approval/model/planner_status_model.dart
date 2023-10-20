class PlannerStatusModelList {
  String? type;
  List<PlannerStatusModelListValues>? values;

  PlannerStatusModelList({this.type, this.values});

  PlannerStatusModelList.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PlannerStatusModelListValues>[];
      json['\$values'].forEach((v) {
        values!.add(PlannerStatusModelListValues.fromJson(v));
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

class PlannerStatusModelListValues {
  String? type;
  int? iSMTPLId;
  int? hRMEId;
  int? iSMTPLPlannedBy;
  String? iSMTPLPlannerName;
  String? iSMTPLRemarks;
  String? iSMTPLStartDate;
  String? iSMTPLEndDate;
  double? iSMTPLTotalHrs;
  bool? iSMTPLApprovalFlg;
  int? iSMTPLApprovedBy;
  bool? iSMTPLActiveFlg;
  String? planDate;
  int? iSMTPLAPId;
  String? plannedby;
  String? iSMTPLAPRemarks;
  String? approvedby;
  String? createdDate;

  PlannerStatusModelListValues(
      {this.type,
      this.iSMTPLId,
      this.hRMEId,
      this.iSMTPLPlannedBy,
      this.iSMTPLPlannerName,
      this.iSMTPLRemarks,
      this.iSMTPLStartDate,
      this.iSMTPLEndDate,
      this.iSMTPLTotalHrs,
      this.iSMTPLApprovalFlg,
      this.iSMTPLApprovedBy,
      this.iSMTPLActiveFlg,
      this.planDate,
      this.iSMTPLAPId,
      this.plannedby,
      this.iSMTPLAPRemarks,
      this.approvedby,
      this.createdDate});

  PlannerStatusModelListValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMTPLId = json['ISMTPL_Id'];
    hRMEId = json['HRME_Id'];
    iSMTPLPlannedBy = json['ISMTPL_PlannedBy'];
    iSMTPLPlannerName = json['ISMTPL_PlannerName'];
    iSMTPLRemarks = json['ISMTPL_Remarks'];
    iSMTPLStartDate = json['ISMTPL_StartDate'];
    iSMTPLEndDate = json['ISMTPL_EndDate'];
    iSMTPLTotalHrs = json['ISMTPL_TotalHrs'];
    iSMTPLApprovalFlg = json['ISMTPL_ApprovalFlg'];
    iSMTPLApprovedBy = json['ISMTPL_ApprovedBy'];
    iSMTPLActiveFlg = json['ISMTPL_ActiveFlg'];
    planDate = json['planDate'];
    iSMTPLAPId = json['ISMTPLAP_Id'];
    plannedby = json['plannedby'];
    iSMTPLAPRemarks = json['ISMTPLAP_Remarks'];
    approvedby = json['approvedby'];
    createdDate = json['CreatedDate'];
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
    data['ISMTPL_ApprovalFlg'] = iSMTPLApprovalFlg;
    data['ISMTPL_ApprovedBy'] = iSMTPLApprovedBy;
    data['ISMTPL_ActiveFlg'] = iSMTPLActiveFlg;
    data['planDate'] = planDate;
    data['ISMTPLAP_Id'] = iSMTPLAPId;
    data['plannedby'] = plannedby;
    data['ISMTPLAP_Remarks'] = iSMTPLAPRemarks;
    data['approvedby'] = approvedby;
    data['CreatedDate'] = createdDate;
    return data;
  }
}
