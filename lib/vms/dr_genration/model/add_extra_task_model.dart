class AddExtraTaskModel {
  String? type;
  List<AddExtraTaskModelValues>? values;

  AddExtraTaskModel({this.type, this.values});

  AddExtraTaskModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AddExtraTaskModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(AddExtraTaskModelValues.fromJson(v));
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

class AddExtraTaskModelValues {
  String? type;
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
  int? hRMEId;
  String? startDate;
  String? endDate;
  double? iSMTPLTAEffortInHrs;
  String? startdatenew;
  String? enddatenew;
  String? createdby;
  String? assignedby;
  String? assignedto;
  int? tasktag;
  int? addtoplannerflag;
  int? iSMMTCATId;
  String? taskcategoryname;
  bool? iSMMTCATCompulsoryFlg;
  String? iSMDRPTTimeTakenInHrsmin;
  String? efforts;
  int? createdFlag;

  AddExtraTaskModelValues(
      {this.type,
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
      this.hRMEId,
      this.startDate,
      this.endDate,
      this.iSMTPLTAEffortInHrs,
      this.startdatenew,
      this.enddatenew,
      this.createdby,
      this.assignedby,
      this.assignedto,
      this.tasktag,
      this.addtoplannerflag,
      this.iSMMTCATId,
      this.taskcategoryname,
      this.iSMMTCATCompulsoryFlg,
      this.iSMDRPTTimeTakenInHrsmin,
      this.efforts,
      this.createdFlag});

  AddExtraTaskModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
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
    hRMEId = json['HRME_Id'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    iSMTPLTAEffortInHrs = json['ISMTPLTA_EffortInHrs'];
    startdatenew = json['startdatenew'];
    enddatenew = json['enddatenew'];
    createdby = json['createdby'];
    assignedby = json['assignedby'];
    assignedto = json['assignedto'];
    tasktag = json['tasktag'];
    addtoplannerflag = json['addtoplannerflag'];
    iSMMTCATId = json['ISMMTCAT_Id'];
    taskcategoryname = json['taskcategoryname'];
    iSMMTCATCompulsoryFlg = json['ISMMTCAT_CompulsoryFlg'];
    iSMDRPTTimeTakenInHrsmin = json['ISMDRPT_TimeTakenInHrsmin'];
    efforts = json['efforts'];
    createdFlag = json['CreatedFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
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
    data['HRME_Id'] = hRMEId;
    data['StartDate'] = startDate;
    data['EndDate'] = endDate;
    data['ISMTPLTA_EffortInHrs'] = iSMTPLTAEffortInHrs;
    data['startdatenew'] = startdatenew;
    data['enddatenew'] = enddatenew;
    data['createdby'] = createdby;
    data['assignedby'] = assignedby;
    data['assignedto'] = assignedto;
    data['tasktag'] = tasktag;
    data['addtoplannerflag'] = addtoplannerflag;
    data['ISMMTCAT_Id'] = iSMMTCATId;
    data['taskcategoryname'] = taskcategoryname;
    data['ISMMTCAT_CompulsoryFlg'] = iSMMTCATCompulsoryFlg;
    data['ISMDRPT_TimeTakenInHrsmin'] = iSMDRPTTimeTakenInHrsmin;
    data['efforts'] = efforts;
    data['CreatedFlag'] = createdFlag;
    return data;
  }
}
