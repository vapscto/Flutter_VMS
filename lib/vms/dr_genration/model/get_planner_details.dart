class GetPlannerDetailsModel {
  String? type;
  List<GetPlannerDetailsModelValues>? values;

  GetPlannerDetailsModel({this.type, this.values});

  GetPlannerDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetPlannerDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetPlannerDetailsModelValues.fromJson(v));
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

class GetPlannerDetailsModelValues {
  int? ismtpLId;
  int? mIId;
  int? hrmEId;
  int? ismtpLPlannedBy;
  String? ismtpLPlannerName;
  String? ismtpLStartDate;
  String? ismtpLEndDate;
  double? ismtpLTotalHrs;
  bool? ismtpLApprovalFlg;
  int? ismtpLApprovedBy;
  bool? ismtpLActiveFlg;
  int? ismtpLCreatedBy;
  int? ismtpLUpdatedBy;
  String? createdDate;
  String? updatedDate;

  GetPlannerDetailsModelValues(
      {this.ismtpLId,
      this.mIId,
      this.hrmEId,
      this.ismtpLPlannedBy,
      this.ismtpLPlannerName,
      this.ismtpLStartDate,
      this.ismtpLEndDate,
      this.ismtpLTotalHrs,
      this.ismtpLApprovalFlg,
      this.ismtpLApprovedBy,
      this.ismtpLActiveFlg,
      this.ismtpLCreatedBy,
      this.ismtpLUpdatedBy,
      this.createdDate,
      this.updatedDate});

  GetPlannerDetailsModelValues.fromJson(Map<String, dynamic> json) {
    ismtpLId = json['ismtpL_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    ismtpLPlannedBy = json['ismtpL_PlannedBy'];
    ismtpLPlannerName = json['ismtpL_PlannerName'];
    ismtpLStartDate = json['ismtpL_StartDate'];
    ismtpLEndDate = json['ismtpL_EndDate'];
    ismtpLTotalHrs = json['ismtpL_TotalHrs'];
    ismtpLApprovalFlg = json['ismtpL_ApprovalFlg'];
    ismtpLApprovedBy = json['ismtpL_ApprovedBy'];
    ismtpLActiveFlg = json['ismtpL_ActiveFlg'];
    ismtpLCreatedBy = json['ismtpL_CreatedBy'];
    ismtpLUpdatedBy = json['ismtpL_UpdatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismtpL_Id'] = ismtpLId;
    data['mI_Id'] = mIId;
    data['hrmE_Id'] = hrmEId;
    data['ismtpL_PlannedBy'] = ismtpLPlannedBy;
    data['ismtpL_PlannerName'] = ismtpLPlannerName;
    data['ismtpL_StartDate'] = ismtpLStartDate;
    data['ismtpL_EndDate'] = ismtpLEndDate;
    data['ismtpL_TotalHrs'] = ismtpLTotalHrs;
    data['ismtpL_ApprovalFlg'] = ismtpLApprovalFlg;
    data['ismtpL_ApprovedBy'] = ismtpLApprovedBy;
    data['ismtpL_ActiveFlg'] = ismtpLActiveFlg;
    data['ismtpL_CreatedBy'] = ismtpLCreatedBy;
    data['ismtpL_UpdatedBy'] = ismtpLUpdatedBy;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
