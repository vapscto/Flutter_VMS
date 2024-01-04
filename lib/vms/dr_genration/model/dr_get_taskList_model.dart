class GetTaskDrListModel {
  String? type;
  List<GetTaskDrListModelValues>? values;

  GetTaskDrListModel({this.type, this.values});

  GetTaskDrListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetTaskDrListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new GetTaskDrListModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetTaskDrListModelValues {
  String? type;
  int? iSMTPLId;
  int? iSMTCRId;
  int? hRMPRId;
  String? hRMPName;
  String? iSMTCRBugOREnhancementFlg;
  String? iSMTCRCreationDate;
  String? iSMTCRTitle;
  String? iSMTCRDesc;
  String? iSMTCRStatus;
  bool? iSMTCRReOpenFlg;
  // Null? iSMTCRReOpenDate;
  String? iSMTCRTaskNo;
  int? iSMMCLTId;
  String? iSMMCLTClientName;
  int? iSMTPLPlannedBy;
  String? iSMTPLPlannerName;
  // Null? iSMTPLRemarks;
  String? iSMTPLStartDate;
  String? iSMTPLEndDate;
  double? iSMTPLTotalHrs;
  bool? iSMTPLApprovalFlg;
  int? iSMTPLApprovedBy;
  bool? iSMTPLActiveFlg;
  String? iSMTPLTAStartDate;
  String? iSMTPLTAEndDate;
  String? assignedby;
  String? createdemp;
  // Null? transferedbyemp;
  //Null? iSMTCRTRTOTransferredDate;
  String? taskcategoryname;
  int? iSMMTCATId;
  String? iSMTAPLPeriodicity;
  String? iSMTAPLDay;
  int? periodicitydailyflag;
  String? iSMTAPLToDate;
  int? periodicityweeklyflag;
  String? periodicityendflag;
  int? iSMTPLTAId;
  bool? iSMMTCATCompulsoryFlg;
  String? iSMDRPTTimeTakenInHrsmins;
  String? effortss;
  String? maxtime;
  double? iSMTPLTAEffortInHrs;
  int? approvedflag;
  String? iSMDRPTRemarks;
  String? iSMDRPTStatus;
  bool? iSMDRPTDeviationFlg;
  bool? iSMDRPTExtraFlg;
  double? iSMDRPTTimeTakenInHrs;
  int? drFlag;
  int? iSMDRId;
  int? hRMEId;
  int? createdFlag;
  int? iSMMPRId;
  String? projectName;

  GetTaskDrListModelValues(
      {this.type,
      this.iSMTPLId,
      this.iSMTCRId,
      this.hRMPRId,
      this.hRMPName,
      this.iSMTCRBugOREnhancementFlg,
      this.iSMTCRCreationDate,
      this.iSMTCRTitle,
      this.iSMTCRDesc,
      this.iSMTCRStatus,
      this.iSMTCRReOpenFlg,
      //  this.iSMTCRReOpenDate,
      this.iSMTCRTaskNo,
      this.iSMMCLTId,
      this.iSMMCLTClientName,
      this.iSMTPLPlannedBy,
      this.iSMTPLPlannerName,
      // this.iSMTPLRemarks,
      this.iSMTPLStartDate,
      this.iSMTPLEndDate,
      this.iSMTPLTotalHrs,
      this.iSMTPLApprovalFlg,
      this.iSMTPLApprovedBy,
      this.iSMTPLActiveFlg,
      this.iSMTPLTAStartDate,
      this.iSMTPLTAEndDate,
      this.assignedby,
      this.createdemp,
      //   this.transferedbyemp,
      //   this.iSMTCRTRTOTransferredDate,
      this.taskcategoryname,
      this.iSMMTCATId,
      this.iSMTAPLPeriodicity,
      this.iSMTAPLDay,
      this.periodicitydailyflag,
      this.iSMTAPLToDate,
      this.periodicityweeklyflag,
      this.periodicityendflag,
      this.iSMTPLTAId,
      this.iSMMTCATCompulsoryFlg,
      this.iSMDRPTTimeTakenInHrsmins,
      this.effortss,
      this.maxtime,
      this.iSMTPLTAEffortInHrs,
      this.approvedflag,
      this.iSMDRPTRemarks,
      this.iSMDRPTStatus,
      this.iSMDRPTDeviationFlg,
      this.iSMDRPTExtraFlg,
      this.iSMDRPTTimeTakenInHrs,
      this.drFlag,
      this.iSMDRId,
      this.hRMEId,
      this.createdFlag,
      this.iSMMPRId,
      this.projectName});

  GetTaskDrListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMTPLId = json['ISMTPL_Id'];
    iSMTCRId = json['ISMTCR_Id'];
    hRMPRId = json['HRMPR_Id'];
    hRMPName = json['HRMP_Name'];
    iSMTCRBugOREnhancementFlg = json['ISMTCR_BugOREnhancementFlg'];
    iSMTCRCreationDate = json['ISMTCR_CreationDate'];
    iSMTCRTitle = json['ISMTCR_Title'];
    iSMTCRDesc = json['ISMTCR_Desc'];
    iSMTCRStatus = json['ISMTCR_Status'];
    iSMTCRReOpenFlg = json['ISMTCR_ReOpenFlg'];
    // iSMTCRReOpenDate = json['ISMTCR_ReOpenDate'];
    iSMTCRTaskNo = json['ISMTCR_TaskNo'];
    iSMMCLTId = json['ISMMCLT_Id'];
    iSMMCLTClientName = json['ISMMCLT_ClientName'];
    iSMTPLPlannedBy = json['ISMTPL_PlannedBy'];
    iSMTPLPlannerName = json['ISMTPL_PlannerName'];
    // iSMTPLRemarks = json['ISMTPL_Remarks'];
    iSMTPLStartDate = json['ISMTPL_StartDate'];
    iSMTPLEndDate = json['ISMTPL_EndDate'];
    iSMTPLTotalHrs = json['ISMTPL_TotalHrs'];
    iSMTPLApprovalFlg = json['ISMTPL_ApprovalFlg'];
    iSMTPLApprovedBy = json['ISMTPL_ApprovedBy'];
    iSMTPLActiveFlg = json['ISMTPL_ActiveFlg'];
    iSMTPLTAStartDate = json['ISMTPLTA_StartDate'];
    iSMTPLTAEndDate = json['ISMTPLTA_EndDate'];
    assignedby = json['assignedby'];
    createdemp = json['createdemp'];
    //  transferedbyemp = json['transferedbyemp'];
    // iSMTCRTRTOTransferredDate = json['ISMTCRTRTO_TransferredDate'];
    taskcategoryname = json['taskcategoryname'];
    iSMMTCATId = json['ISMMTCAT_Id'];
    iSMTAPLPeriodicity = json['ISMTAPL_Periodicity'];
    iSMTAPLDay = json['ISMTAPL_Day'];
    periodicitydailyflag = json['periodicitydailyflag'];
    iSMTAPLToDate = json['ISMTAPL_ToDate'];
    periodicityweeklyflag = json['periodicityweeklyflag'];
    periodicityendflag = json['periodicityendflag'];
    iSMTPLTAId = json['ISMTPLTA_Id'];
    iSMMTCATCompulsoryFlg = json['ISMMTCAT_CompulsoryFlg'];
    iSMDRPTTimeTakenInHrsmins = json['ISMDRPT_TimeTakenInHrsmins'];
    effortss = json['effortss'];
    maxtime = json['maxtime'];
    iSMTPLTAEffortInHrs = json['ISMTPLTA_EffortInHrs'];
    approvedflag = json['approvedflag'];
    iSMDRPTRemarks = json['ISMDRPT_Remarks'];
    iSMDRPTStatus = json['ISMDRPT_Status'];
    iSMDRPTDeviationFlg = json['ISMDRPT_DeviationFlg'];
    iSMDRPTExtraFlg = json['ISMDRPT_ExtraFlg'];
    iSMDRPTTimeTakenInHrs = json['ISMDRPT_TimeTakenInHrs'];
    drFlag = json['dr_flag'];
    iSMDRId = json['ISMDR_Id'];
    hRMEId = json['HRME_Id'];
    createdFlag = json['CreatedFlag'];
    iSMMPRId = json['ISMMPR_Id'];
    projectName = json['ProjectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMTPL_Id'] = iSMTPLId;
    data['ISMTCR_Id'] = iSMTCRId;
    data['HRMPR_Id'] = hRMPRId;
    data['HRMP_Name'] = hRMPName;
    data['ISMTCR_BugOREnhancementFlg'] = iSMTCRBugOREnhancementFlg;
    data['ISMTCR_CreationDate'] = iSMTCRCreationDate;
    data['ISMTCR_Title'] = iSMTCRTitle;
    data['ISMTCR_Desc'] = iSMTCRDesc;
    data['ISMTCR_Status'] = iSMTCRStatus;
    data['ISMTCR_ReOpenFlg'] = iSMTCRReOpenFlg;
    //  data['ISMTCR_ReOpenDate'] = this.iSMTCRReOpenDate;
    data['ISMTCR_TaskNo'] = iSMTCRTaskNo;
    data['ISMMCLT_Id'] = iSMMCLTId;
    data['ISMMCLT_ClientName'] = iSMMCLTClientName;
    data['ISMTPL_PlannedBy'] = iSMTPLPlannedBy;
    data['ISMTPL_PlannerName'] = iSMTPLPlannerName;
    //  data['ISMTPL_Remarks'] = this.iSMTPLRemarks;
    data['ISMTPL_StartDate'] = iSMTPLStartDate;
    data['ISMTPL_EndDate'] = iSMTPLEndDate;
    data['ISMTPL_TotalHrs'] = iSMTPLTotalHrs;
    data['ISMTPL_ApprovalFlg'] = iSMTPLApprovalFlg;
    data['ISMTPL_ApprovedBy'] = iSMTPLApprovedBy;
    data['ISMTPL_ActiveFlg'] = iSMTPLActiveFlg;
    data['ISMTPLTA_StartDate'] = iSMTPLTAStartDate;
    data['ISMTPLTA_EndDate'] = iSMTPLTAEndDate;
    data['assignedby'] = assignedby;
    data['createdemp'] = createdemp;
    //  data['transferedbyemp'] = this.transferedbyemp;
    //  data['ISMTCRTRTO_TransferredDate'] = this.iSMTCRTRTOTransferredDate;
    data['taskcategoryname'] = taskcategoryname;
    data['ISMMTCAT_Id'] = iSMMTCATId;
    data['ISMTAPL_Periodicity'] = iSMTAPLPeriodicity;
    data['ISMTAPL_Day'] = iSMTAPLDay;
    data['periodicitydailyflag'] = periodicitydailyflag;
    data['ISMTAPL_ToDate'] = iSMTAPLToDate;
    data['periodicityweeklyflag'] = periodicityweeklyflag;
    data['periodicityendflag'] = periodicityendflag;
    data['ISMTPLTA_Id'] = iSMTPLTAId;
    data['ISMMTCAT_CompulsoryFlg'] = iSMMTCATCompulsoryFlg;
    data['ISMDRPT_TimeTakenInHrsmins'] = iSMDRPTTimeTakenInHrsmins;
    data['effortss'] = effortss;
    data['maxtime'] = maxtime;
    data['ISMTPLTA_EffortInHrs'] = iSMTPLTAEffortInHrs;
    data['approvedflag'] = approvedflag;
    data['ISMDRPT_Remarks'] = iSMDRPTRemarks;
    data['ISMDRPT_Status'] = iSMDRPTStatus;
    data['ISMDRPT_DeviationFlg'] = iSMDRPTDeviationFlg;
    data['ISMDRPT_ExtraFlg'] = iSMDRPTExtraFlg;
    data['ISMDRPT_TimeTakenInHrs'] = iSMDRPTTimeTakenInHrs;
    data['dr_flag'] = drFlag;
    data['ISMDR_Id'] = iSMDRId;
    data['HRME_Id'] = hRMEId;
    data['CreatedFlag'] = createdFlag;
    data['ISMMPR_Id'] = iSMMPRId;
    data['ProjectName'] = projectName;
    return data;
  }
}
