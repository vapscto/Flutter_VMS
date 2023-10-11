class PlannerListModel {
  String? type;
  List<PlannerListModelValues>? values;

  PlannerListModel({this.type, this.values});

  PlannerListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PlannerListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(PlannerListModelValues.fromJson(v));
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

class PlannerListModelValues {
  String? type;
  int? iSMTPLId;
  int? hRMEId;
  int? iSMTPLPlannedBy;
  String? iSMTPLPlannerName;
  Null? iSMTPLRemarks;
  String? iSMTPLStartDate;
  String? iSMTPLEndDate;
  double? iSMTPLTotalHrs;
  bool? iSMTPLApprovalFlg;
  int? iSMTPLApprovedBy;
  bool? iSMTPLActiveFlg;
  String? planDate;
  String? plannedby;
  int? mIId;
  int? drappDatecount;

  PlannerListModelValues(
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
      this.plannedby,
      this.mIId,
      this.drappDatecount});

  PlannerListModelValues.fromJson(Map<String, dynamic> json) {
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
    plannedby = json['plannedby'];
    mIId = json['MI_Id'];
    drappDatecount = json['DrappDatecount'];
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
    data['plannedby'] = plannedby;
    data['MI_Id'] = mIId;
    data['DrappDatecount'] = drappDatecount;
    return data;
  }
}
