class PlannerApprovalListModel {
  String? type;
  List<PlannerApprovalListModelValues>? values;

  PlannerApprovalListModel({this.type, this.values});

  PlannerApprovalListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PlannerApprovalListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(PlannerApprovalListModelValues.fromJson(v));
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

class PlannerApprovalListModelValues {
  String? type;
  int? iSMTPLId;
  int? iSMTPLTAId;
  int? iSMTCRId;
  int? hRMPRId;
  String? hRMPName;
  String? bugOREnhancementFlg;
  int? iSMTPLAPId;
  String? iSMTCRBugOREnhancement;
  String? iSMTCRCreationDate;
  String? iSMTCRTitle;
  String? iSMTCRDesc;
  String? createdDate;
  String? iSMTCRStatus;
  bool? iSMTCRReOpenFlg;
  dynamic iSMTCRReOpenDate;
  String? iSMTCRTaskNo;
  int? iSMMCLTId;
  String? iSMMCLTClientName;
  int? iSMTPLCreatedBy;
  String? plannerDate;
  String? iSMTPLTAStatus;
  int? iSMTPLPlannedBy;
  String? iSMTPLPlannerName;
  String? iSMTPLRemarks;
  String? iSMTPLStartDate;
  String? iSMTPLEndDate;
  double? iSMTPLTotalHrs;
  bool? iSMTPLApprovalFlg;
  int? iSMTPLApprovedBy;
  bool? iSMTPLActiveFlg;
  bool? iSMTPLTAApprovalFlg;
  String? iSMTPLTAStartDate;
  String? iSMTPLTAEndDate;
  String? iSMTCRASTOStartDate;
  String? iSMTCRASTOEndDate;
  double? iSMTPLTAEffortInHrs;
  String? iSMTPLTARemarks;
  int? mIId;
  String? plannedby;
  bool? iSMTPLTAPreviousTask;
  String? iSMMTCATTaskCategoryName;
  String? createdby;
  double? iSMMTCATTaskPercentage;
  String? iSMMTCATDurationFlg;
  bool? iSMMTCATCompulsoryFlg;
  String? iSMMTCATEachTaskMaxDuration;
  int? iSMMTCATId;
  String? periodicity;
  int? pTSCount;
  double? eachtaskeff;

  PlannerApprovalListModelValues(
      {this.type,
      this.iSMTPLId,
      this.iSMTPLTAId,
      this.iSMTCRId,
      this.hRMPRId,
      this.hRMPName,
      this.bugOREnhancementFlg,
      this.iSMTPLAPId,
      this.iSMTCRBugOREnhancement,
      this.iSMTCRCreationDate,
      this.iSMTCRTitle,
      this.iSMTCRDesc,
      this.createdDate,
      this.iSMTCRStatus,
      this.iSMTCRReOpenFlg,
      this.iSMTCRReOpenDate,
      this.iSMTCRTaskNo,
      this.iSMMCLTId,
      this.iSMMCLTClientName,
      this.iSMTPLCreatedBy,
      this.plannerDate,
      this.iSMTPLTAStatus,
      this.iSMTPLPlannedBy,
      this.iSMTPLPlannerName,
      this.iSMTPLRemarks,
      this.iSMTPLStartDate,
      this.iSMTPLEndDate,
      this.iSMTPLTotalHrs,
      this.iSMTPLApprovalFlg,
      this.iSMTPLApprovedBy,
      this.iSMTPLActiveFlg,
      this.iSMTPLTAApprovalFlg,
      this.iSMTPLTAStartDate,
      this.iSMTPLTAEndDate,
      this.iSMTCRASTOStartDate,
      this.iSMTCRASTOEndDate,
      this.iSMTPLTAEffortInHrs,
      this.iSMTPLTARemarks,
      this.mIId,
      this.plannedby,
      this.iSMTPLTAPreviousTask,
      this.iSMMTCATTaskCategoryName,
      this.createdby,
      this.iSMMTCATTaskPercentage,
      this.iSMMTCATDurationFlg,
      this.iSMMTCATCompulsoryFlg,
      this.iSMMTCATEachTaskMaxDuration,
      this.iSMMTCATId,
      this.periodicity,
      this.pTSCount,
      this.eachtaskeff});

  PlannerApprovalListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMTPLId = json['ISMTPL_Id'];
    iSMTPLTAId = json['ISMTPLTA_Id'];
    iSMTCRId = json['ISMTCR_Id'];
    hRMPRId = json['HRMPR_Id'];
    hRMPName = json['HRMP_Name'];
    bugOREnhancementFlg = json['BugOREnhancementFlg'];
    iSMTPLAPId = json['ISMTPLAP_Id'];
    iSMTCRBugOREnhancement = json['ISMTCR_BugOREnhancement'];
    iSMTCRCreationDate = json['ISMTCR_CreationDate'];
    iSMTCRTitle = json['ISMTCR_Title'];
    iSMTCRDesc = json['ISMTCR_Desc'];
    createdDate = json['CreatedDate'];
    iSMTCRStatus = json['ISMTCR_Status'];
    iSMTCRReOpenFlg = json['ISMTCR_ReOpenFlg'];
    iSMTCRReOpenDate = json['ISMTCR_ReOpenDate'];
    iSMTCRTaskNo = json['ISMTCR_TaskNo'];
    iSMMCLTId = json['ISMMCLT_Id'];
    iSMMCLTClientName = json['ISMMCLT_ClientName'];
    iSMTPLCreatedBy = json['ISMTPL_CreatedBy'];
    plannerDate = json['plannerDate'];
    iSMTPLTAStatus = json['ISMTPLTA_Status'];
    iSMTPLPlannedBy = json['ISMTPL_PlannedBy'];
    iSMTPLPlannerName = json['ISMTPL_PlannerName'];
    iSMTPLRemarks = json['ISMTPL_Remarks'];
    iSMTPLStartDate = json['ISMTPL_StartDate'];
    iSMTPLEndDate = json['ISMTPL_EndDate'];
    iSMTPLTotalHrs = json['ISMTPL_TotalHrs'];
    iSMTPLApprovalFlg = json['ISMTPL_ApprovalFlg'];
    iSMTPLApprovedBy = json['ISMTPL_ApprovedBy'];
    iSMTPLActiveFlg = json['ISMTPL_ActiveFlg'];
    iSMTPLTAApprovalFlg = json['ISMTPLTA_ApprovalFlg'];
    iSMTPLTAStartDate = json['ISMTPLTA_StartDate'];
    iSMTPLTAEndDate = json['ISMTPLTA_EndDate'];
    iSMTCRASTOStartDate = json['ISMTPL_StartDate'];
    iSMTCRASTOEndDate = json['ISMTPL_EndDate'];
    iSMTPLTAEffortInHrs = json['ISMTPLTA_EffortInHrs'];
    iSMTPLTARemarks = json['ISMTPLTA_Remarks'];
    mIId = json['MI_Id'];
    plannedby = json['plannedby'];
    iSMTPLTAPreviousTask = json['ISMTPLTA_PreviousTask'];
    iSMMTCATTaskCategoryName = json['ISMMTCAT_TaskCategoryName'];
    createdby = json['createdby'];
    iSMMTCATTaskPercentage = json['ISMMTCAT_TaskPercentage'];
    iSMMTCATDurationFlg = json['ISMMTCAT_DurationFlg'];
    iSMMTCATCompulsoryFlg = json['ISMMTCAT_CompulsoryFlg'];
    iSMMTCATEachTaskMaxDuration = json['ISMMTCAT_EachTaskMaxDuration'];
    iSMMTCATId = json['ISMMTCAT_Id'];
    periodicity = json['Periodicity'];
    pTSCount = json['PTSCount'];
    eachtaskeff = json['eachtaskeff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMTPL_Id'] = iSMTPLId;
    data['ISMTPLTA_Id'] = iSMTPLTAId;
    data['ISMTCR_Id'] = iSMTCRId;
    data['HRMPR_Id'] = hRMPRId;
    data['HRMP_Name'] = hRMPName;
    data['BugOREnhancementFlg'] = bugOREnhancementFlg;
    data['ISMTPLAP_Id'] = iSMTPLAPId;
    data['ISMTCR_BugOREnhancement'] = iSMTCRBugOREnhancement;
    data['ISMTCR_CreationDate'] = iSMTCRCreationDate;
    data['ISMTCR_Title'] = iSMTCRTitle;
    data['ISMTCR_Desc'] = iSMTCRDesc;
    data['CreatedDate'] = createdDate;
    data['ISMTCR_Status'] = iSMTCRStatus;
    data['ISMTCR_ReOpenFlg'] = iSMTCRReOpenFlg;
    data['ISMTCR_ReOpenDate'] = iSMTCRReOpenDate;
    data['ISMTCR_TaskNo'] = iSMTCRTaskNo;
    data['ISMMCLT_Id'] = iSMMCLTId;
    data['ISMMCLT_ClientName'] = iSMMCLTClientName;
    data['ISMTPL_CreatedBy'] = iSMTPLCreatedBy;
    data['plannerDate'] = plannerDate;
    data['ISMTPLTA_Status'] = iSMTPLTAStatus;
    data['ISMTPL_PlannedBy'] = iSMTPLPlannedBy;
    data['ISMTPL_PlannerName'] = iSMTPLPlannerName;
    data['ISMTPL_Remarks'] = iSMTPLRemarks;
    data['ISMTPL_StartDate'] = iSMTPLStartDate;
    data['ISMTPL_EndDate'] = iSMTPLEndDate;
    data['ISMTPL_TotalHrs'] = iSMTPLTotalHrs;
    data['ISMTPL_ApprovalFlg'] = iSMTPLApprovalFlg;
    data['ISMTPL_ApprovedBy'] = iSMTPLApprovedBy;
    data['ISMTPL_ActiveFlg'] = iSMTPLActiveFlg;
    data['ISMTPLTA_ApprovalFlg'] = iSMTPLTAApprovalFlg;
    data['ISMTPLTA_StartDate'] = iSMTPLTAStartDate;
    data['ISMTPLTA_EndDate'] = iSMTPLTAEndDate;
    data['ISMTPL_StartDate'] = iSMTCRASTOStartDate;
    data['ISMTPL_EndDate'] = iSMTCRASTOEndDate;
    data['ISMTPLTA_EffortInHrs'] = iSMTPLTAEffortInHrs;
    data['ISMTPLTA_Remarks'] = iSMTPLTARemarks;
    data['MI_Id'] = mIId;
    data['plannedby'] = plannedby;
    data['ISMTPLTA_PreviousTask'] = iSMTPLTAPreviousTask;
    data['ISMMTCAT_TaskCategoryName'] = iSMMTCATTaskCategoryName;
    data['createdby'] = createdby;
    data['ISMMTCAT_TaskPercentage'] = iSMMTCATTaskPercentage;
    data['ISMMTCAT_DurationFlg'] = iSMMTCATDurationFlg;
    data['ISMMTCAT_CompulsoryFlg'] = iSMMTCATCompulsoryFlg;
    data['ISMMTCAT_EachTaskMaxDuration'] = iSMMTCATEachTaskMaxDuration;
    data['ISMMTCAT_Id'] = iSMMTCATId;
    data['Periodicity'] = periodicity;
    data['PTSCount'] = pTSCount;
    data['eachtaskeff'] = eachtaskeff;
    return data;
  }
}
