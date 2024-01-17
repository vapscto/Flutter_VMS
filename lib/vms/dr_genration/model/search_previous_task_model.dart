class SearchPreviousTaskModel {
  String? type;
  List<SearchPreviousTaskModelValues>? values;

  SearchPreviousTaskModel({this.type, this.values});

  SearchPreviousTaskModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <SearchPreviousTaskModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(SearchPreviousTaskModelValues.fromJson(v));
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

class SearchPreviousTaskModelValues {
  String? type;
  int? iSMDRPTId;
  String? iSMTCRTaskNo;
  String? hRMPName;
  String? iSMTCRDesc;
  String? iSMDRPTStatus;
  String? iSMDRPTDate;
  String? iSMDRPTRemarks;
  String? iSMTCRBugOREnhancementFlg;
  String? iSMDRPTTimeTakenInHrs;
  String? iSMMCLTClientName;
  String? assignedby;
  String? taskcategoryname;
  double? efforts;
  int? count;
  String? iSMDRPTApprovedFlg;
  double? iSMDRPTApprovedTime;
  String? rEMARKS;

  SearchPreviousTaskModelValues(
      {this.type,
      this.iSMDRPTId,
      this.iSMTCRTaskNo,
      this.hRMPName,
      this.iSMTCRDesc,
      this.iSMDRPTStatus,
      this.iSMDRPTDate,
      this.iSMDRPTRemarks,
      this.iSMTCRBugOREnhancementFlg,
      this.iSMDRPTTimeTakenInHrs,
      this.iSMMCLTClientName,
      this.assignedby,
      this.taskcategoryname,
      this.efforts,
      this.count,
      this.iSMDRPTApprovedFlg,
      this.iSMDRPTApprovedTime,
      this.rEMARKS});

  SearchPreviousTaskModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMDRPTId = json['ISMDRPT_Id'];
    iSMTCRTaskNo = json['ISMTCR_TaskNo'];
    hRMPName = json['HRMP_Name'];
    iSMTCRDesc = json['ISMTCR_Desc'];
    iSMDRPTStatus = json['ISMDRPT_Status'];
    iSMDRPTDate = json['ISMDRPT_Date'];
    iSMDRPTRemarks = json['ISMDRPT_Remarks'];
    iSMTCRBugOREnhancementFlg = json['ISMTCR_BugOREnhancementFlg'];
    iSMDRPTTimeTakenInHrs = json['ISMDRPT_TimeTakenInHrs'];
    iSMMCLTClientName = json['ISMMCLT_ClientName'];
    assignedby = json['assignedby'];
    taskcategoryname = json['taskcategoryname'];
    efforts = json['efforts'];
    count = json['Count'];
    iSMDRPTApprovedFlg = json['ISMDRPT_ApprovedFlg'];
    iSMDRPTApprovedTime = json['ISMDRPT_ApprovedTime'];
    rEMARKS = json['REMARKS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMDRPT_Id'] = iSMDRPTId;
    data['ISMTCR_TaskNo'] = iSMTCRTaskNo;
    data['HRMP_Name'] = hRMPName;
    data['ISMTCR_Desc'] = iSMTCRDesc;
    data['ISMDRPT_Status'] = iSMDRPTStatus;
    data['ISMDRPT_Date'] = iSMDRPTDate;
    data['ISMDRPT_Remarks'] = iSMDRPTRemarks;
    data['ISMTCR_BugOREnhancementFlg'] = iSMTCRBugOREnhancementFlg;
    data['ISMDRPT_TimeTakenInHrs'] = iSMDRPTTimeTakenInHrs;
    data['ISMMCLT_ClientName'] = iSMMCLTClientName;
    data['assignedby'] = assignedby;
    data['taskcategoryname'] = taskcategoryname;
    data['efforts'] = efforts;
    data['Count'] = count;
    data['ISMDRPT_ApprovedFlg'] = iSMDRPTApprovedFlg;
    data['ISMDRPT_ApprovedTime'] = iSMDRPTApprovedTime;
    data['REMARKS'] = rEMARKS;
    return data;
  }
}
