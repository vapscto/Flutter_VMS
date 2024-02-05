class DrDetailModel {
  String? type;
  List<DrDetailModelValues>? values;

  DrDetailModel({this.type, this.values});

  DrDetailModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DrDetailModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DrDetailModelValues.fromJson(v));
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

class DrDetailModelValues {
  String? type;
  int? iSMDRPTId;
  int? iSMTCRId;
  String? iSMTCRTaskNo;
  String? iSMTCRTitle;
  String? iSMDRPTStatus;
  double? iSMDRPTTimeTakenInHrs;
  double? iSMTPLTAEffortInHrs;
  String? iSMDRPTDate;
  int? cOUNTCHECKLIST;
  String? eMPLOYEENAME;
  String? eMPLOYEECODE;
  String? dEPTNAME;
  String? dESGNAME;
  int? hRMEId;
  String? iSMDRPTRemarks;
  int? iSMTPLTAId;
  int? iSMTCRIdRejected;
  String? iSMMTCATTaskCategoryName;
  int? tASKCREATEDBY;
  int? periodicitydailyflag;
  String? iSMTAPLPeriodicity;

  DrDetailModelValues(
      {this.type,
      this.iSMDRPTId,
      this.iSMTCRId,
      this.iSMTCRTaskNo,
      this.iSMTCRTitle,
      this.iSMDRPTStatus,
      this.iSMDRPTTimeTakenInHrs,
      this.iSMTPLTAEffortInHrs,
      this.iSMDRPTDate,
      this.cOUNTCHECKLIST,
      this.eMPLOYEENAME,
      this.eMPLOYEECODE,
      this.dEPTNAME,
      this.dESGNAME,
      this.hRMEId,
      this.iSMDRPTRemarks,
      this.iSMTPLTAId,
      this.iSMTCRIdRejected,
      this.iSMMTCATTaskCategoryName,
      this.tASKCREATEDBY,
      this.periodicitydailyflag,
      this.iSMTAPLPeriodicity});

  DrDetailModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    iSMDRPTId = json['ISMDRPT_Id'];
    iSMTCRId = json['ISMTCR_Id'];
    iSMTCRTaskNo = json['ISMTCR_TaskNo'];
    iSMTCRTitle = json['ISMTCR_Title'];
    iSMDRPTStatus = json['ISMDRPT_Status'];
    iSMDRPTTimeTakenInHrs = json['ISMDRPT_TimeTakenInHrs'];
    iSMTPLTAEffortInHrs = json['ISMTPLTA_EffortInHrs'];
    iSMDRPTDate = json['ISMDRPT_Date'];
    cOUNTCHECKLIST = json['COUNTCHECKLIST'];
    eMPLOYEENAME = json['EMPLOYEENAME'];
    eMPLOYEECODE = json['EMPLOYEECODE'];
    dEPTNAME = json['DEPTNAME'];
    dESGNAME = json['DESGNAME'];
    hRMEId = json['HRME_Id'];
    iSMDRPTRemarks = json['ISMDRPT_Remarks'];
    iSMTPLTAId = json['ISMTPLTA_Id'];
    iSMTCRIdRejected = json['ISMTCR_Id_rejected'];
    iSMMTCATTaskCategoryName = json['ISMMTCAT_TaskCategoryName'];
    tASKCREATEDBY = json['TASK_CREATED_BY'];
    periodicitydailyflag = json['periodicitydailyflag'];
    iSMTAPLPeriodicity = json['ISMTAPL_Periodicity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    data['ISMDRPT_Id'] = iSMDRPTId;
    data['ISMTCR_Id'] = iSMTCRId;
    data['ISMTCR_TaskNo'] = iSMTCRTaskNo;
    data['ISMTCR_Title'] = iSMTCRTitle;
    data['ISMDRPT_Status'] = iSMDRPTStatus;
    data['ISMDRPT_TimeTakenInHrs'] = iSMDRPTTimeTakenInHrs;
    data['ISMTPLTA_EffortInHrs'] = iSMTPLTAEffortInHrs;
    data['ISMDRPT_Date'] = iSMDRPTDate;
    data['COUNTCHECKLIST'] = cOUNTCHECKLIST;
    data['EMPLOYEENAME'] = eMPLOYEENAME;
    data['EMPLOYEECODE'] = eMPLOYEECODE;
    data['DEPTNAME'] = dEPTNAME;
    data['DESGNAME'] = dESGNAME;
    data['HRME_Id'] = hRMEId;
    data['ISMDRPT_Remarks'] = iSMDRPTRemarks;
    data['ISMTPLTA_Id'] = iSMTPLTAId;
    data['ISMTCR_Id_rejected'] = iSMTCRIdRejected;
    data['ISMMTCAT_TaskCategoryName'] = iSMMTCATTaskCategoryName;
    data['TASK_CREATED_BY'] = tASKCREATEDBY;
    data['periodicitydailyflag'] = periodicitydailyflag;
    data['ISMTAPL_Periodicity'] = iSMTAPLPeriodicity;
    return data;
  }
}
