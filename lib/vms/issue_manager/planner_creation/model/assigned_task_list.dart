class AssignedTaskList {
  String? type;
  List<AssignedTaskListValues>? values;

  AssignedTaskList({this.type, this.values});

  AssignedTaskList.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AssignedTaskListValues>[];
      json['\$values'].forEach((v) {
        values!.add(AssignedTaskListValues.fromJson(v));
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

class AssignedTaskListValues {
  String? type;
  int? iSMTCRASTOId;
  int? iSMTCRId;
  int? hRMDId;
  String? hRMDDepartmentName;
  int? hRMPRId;
  String? hRMPName;
  String? iSMTCRBugOREnhancementFlg;
  String? iSMTCRCreationDate;
  String? iSMTCRTitle;
  String? iSMTCRDesc;
  String? iSMTCRStatus;
  bool? iSMTCRReOpenFlg;
  String? iSMTCRReOpenDate;
  String? iSMTCRTaskNo;
  int? iSMMCLTId;
  String? iSMMCLTClientName;
  String? iSMTCRASTOAssignedDate;
  String? iSMTCRASTORemarks;
  String? iSMTCRASTOStartDate;
  String? iSMTCRASTOEndDate;
  double? iSMTCRASTOEffortInHrs;
  String? assignedby;
  String? periodicity;
  String? iSMTAPLDay;
  String? oFFDate;
  int? iSMTPLTAId;
  int? iSMMTCATId;
  String? iSMMTCATTaskCategoryName;
  bool? iSMMTCATCompulsoryFlg;
  String? iSMTPLTAStatus;
  int? iSMTPLTAPreviousTask;
  String? iSMTPLTAApprovalFlg;
  String? iSMTPLTAStartDate;
  String? iSMTPLTAEndDate;
  Null? yrplan;
  int? priorityswitch;
  String? firstDate1;
  String? firstDate2;
  String? weekStartDate;
  String? weekEndDate;
  String? addeddate1;
  String? addeddate2;
  int? firsttrue;
  int? secondtrue;
  int? weekfirsttrue;
  int? weeksecondtrue;

  AssignedTaskListValues(
      {this.type,
      this.iSMTCRASTOId,
      this.iSMTCRId,
      this.hRMDId,
      this.hRMDDepartmentName,
      this.hRMPRId,
      this.hRMPName,
      this.iSMTCRBugOREnhancementFlg,
      this.iSMTCRCreationDate,
      this.iSMTCRTitle,
      this.iSMTCRDesc,
      this.iSMTCRStatus,
      this.iSMTCRReOpenFlg,
      this.iSMTCRReOpenDate,
      this.iSMTCRTaskNo,
      this.iSMMCLTId,
      this.iSMMCLTClientName,
      this.iSMTCRASTOAssignedDate,
      this.iSMTCRASTORemarks,
      this.iSMTCRASTOStartDate,
      this.iSMTCRASTOEndDate,
      this.iSMTCRASTOEffortInHrs,
      this.assignedby,
      this.periodicity,
      this.iSMTAPLDay,
      this.oFFDate,
      this.iSMTPLTAId,
      this.iSMMTCATId,
      this.iSMMTCATTaskCategoryName,
      this.iSMMTCATCompulsoryFlg,
      this.iSMTPLTAStatus,
      this.iSMTPLTAPreviousTask,
      this.iSMTPLTAApprovalFlg,
      this.iSMTPLTAStartDate,
      this.iSMTPLTAEndDate,
      this.yrplan,
      this.priorityswitch,
      this.firstDate1,
      this.firstDate2,
      this.weekStartDate,
      this.weekEndDate,
      this.addeddate1,
      this.addeddate2,
      this.firsttrue,
      this.secondtrue,
      this.weekfirsttrue,
      this.weeksecondtrue});

  AssignedTaskListValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMTCRASTOId = json['ISMTCRASTO_Id'];
    iSMTCRId = json['ISMTCR_Id'];
    hRMDId = json['HRMD_Id'];
    hRMDDepartmentName = json['HRMD_DepartmentName'];
    hRMPRId = json['HRMPR_Id'];
    hRMPName = json['HRMP_Name'];
    iSMTCRBugOREnhancementFlg = json['ISMTCR_BugOREnhancementFlg'];
    iSMTCRCreationDate = json['ISMTCR_CreationDate'];
    iSMTCRTitle = json['ISMTCR_Title'];
    iSMTCRDesc = json['ISMTCR_Desc'];
    iSMTCRStatus = json['ISMTCR_Status'];
    iSMTCRReOpenFlg = json['ISMTCR_ReOpenFlg'];
    iSMTCRReOpenDate = json['ISMTCR_ReOpenDate'];
    iSMTCRTaskNo = json['ISMTCR_TaskNo'];
    iSMMCLTId = json['ISMMCLT_Id'];
    iSMMCLTClientName = json['ISMMCLT_ClientName'];
    iSMTCRASTOAssignedDate = json['ISMTCRASTO_AssignedDate'];
    iSMTCRASTORemarks = json['ISMTCRASTO_Remarks'];
    iSMTCRASTOStartDate = json['ISMTCRASTO_StartDate'];
    iSMTCRASTOEndDate = json['ISMTCRASTO_EndDate'];
    iSMTCRASTOEffortInHrs = json['ISMTCRASTO_EffortInHrs'];
    assignedby = json['assignedby'];
    periodicity = json['Periodicity'];
    iSMTAPLDay = json['ISMTAPL_Day'];
    oFFDate = json['OFFDate'];
    iSMTPLTAId = json['ISMTPLTA_Id'];
    iSMMTCATId = json['ISMMTCAT_Id'];
    iSMMTCATTaskCategoryName = json['ISMMTCAT_TaskCategoryName'];
    iSMMTCATCompulsoryFlg = json['ISMMTCAT_CompulsoryFlg'];
    iSMTPLTAStatus = json['ISMTPLTA_Status'];
    iSMTPLTAPreviousTask = json['ISMTPLTA_PreviousTask'];
    iSMTPLTAApprovalFlg = json['ISMTPLTA_ApprovalFlg'];
    iSMTPLTAStartDate = json['ISMTPLTA_StartDate'];
    iSMTPLTAEndDate = json['ISMTPLTA_EndDate'];
    yrplan = json['yrplan'];
    priorityswitch = json['priorityswitch'];
    firstDate1 = json['FirstDate1'];
    firstDate2 = json['FirstDate2'];
    weekStartDate = json['WeekStartDate'];
    weekEndDate = json['WeekEndDate'];
    addeddate1 = json['addeddate1'];
    addeddate2 = json['addeddate2'];
    firsttrue = json['firsttrue'];
    secondtrue = json['secondtrue'];
    weekfirsttrue = json['Weekfirsttrue'];
    weeksecondtrue = json['Weeksecondtrue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMTCRASTO_Id'] = iSMTCRASTOId;
    data['ISMTCR_Id'] = iSMTCRId;
    data['HRMD_Id'] = hRMDId;
    data['HRMD_DepartmentName'] = hRMDDepartmentName;
    data['HRMPR_Id'] = hRMPRId;
    data['HRMP_Name'] = hRMPName;
    data['ISMTCR_BugOREnhancementFlg'] = iSMTCRBugOREnhancementFlg;
    data['ISMTCR_CreationDate'] = iSMTCRCreationDate;
    data['ISMTCR_Title'] = iSMTCRTitle;
    data['ISMTCR_Desc'] = iSMTCRDesc;
    data['ISMTCR_Status'] = iSMTCRStatus;
    data['ISMTCR_ReOpenFlg'] = iSMTCRReOpenFlg;
    data['ISMTCR_ReOpenDate'] = iSMTCRReOpenDate;
    data['ISMTCR_TaskNo'] = iSMTCRTaskNo;
    data['ISMMCLT_Id'] = iSMMCLTId;
    data['ISMMCLT_ClientName'] = iSMMCLTClientName;
    data['ISMTCRASTO_AssignedDate'] = iSMTCRASTOAssignedDate;
    data['ISMTCRASTO_Remarks'] = iSMTCRASTORemarks;
    data['ISMTCRASTO_StartDate'] = iSMTCRASTOStartDate;
    data['ISMTCRASTO_EndDate'] = iSMTCRASTOEndDate;
    data['ISMTCRASTO_EffortInHrs'] = iSMTCRASTOEffortInHrs;
    data['assignedby'] = assignedby;
    data['Periodicity'] = periodicity;
    data['ISMTAPL_Day'] = iSMTAPLDay;
    data['OFFDate'] = oFFDate;
    data['ISMTPLTA_Id'] = iSMTPLTAId;
    data['ISMMTCAT_Id'] = iSMMTCATId;
    data['ISMMTCAT_TaskCategoryName'] = iSMMTCATTaskCategoryName;
    data['ISMMTCAT_CompulsoryFlg'] = iSMMTCATCompulsoryFlg;
    data['ISMTPLTA_Status'] = iSMTPLTAStatus;
    data['ISMTPLTA_PreviousTask'] = iSMTPLTAPreviousTask;
    data['ISMTPLTA_ApprovalFlg'] = iSMTPLTAApprovalFlg;
    data['ISMTPLTA_StartDate'] = iSMTPLTAStartDate;
    data['ISMTPLTA_EndDate'] = iSMTPLTAEndDate;
    data['yrplan'] = yrplan;
    data['priorityswitch'] = priorityswitch;
    data['FirstDate1'] = firstDate1;
    data['FirstDate2'] = firstDate2;
    data['WeekStartDate'] = weekStartDate;
    data['WeekEndDate'] = weekEndDate;
    data['addeddate1'] = addeddate1;
    data['addeddate2'] = addeddate2;
    data['firsttrue'] = firsttrue;
    data['secondtrue'] = secondtrue;
    data['Weekfirsttrue'] = weekfirsttrue;
    data['Weeksecondtrue'] = weeksecondtrue;
    return data;
  }
}
