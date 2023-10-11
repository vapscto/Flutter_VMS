class DrDetailModel {
  String? type;
  List<DrDetailModelValues>? values;

  DrDetailModel({this.type, this.values});

  DrDetailModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DrDetailModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new DrDetailModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    data['ISMDRPT_Id'] = this.iSMDRPTId;
    data['ISMTCR_Id'] = this.iSMTCRId;
    data['ISMTCR_TaskNo'] = this.iSMTCRTaskNo;
    data['ISMTCR_Title'] = this.iSMTCRTitle;
    data['ISMDRPT_Status'] = this.iSMDRPTStatus;
    data['ISMDRPT_TimeTakenInHrs'] = this.iSMDRPTTimeTakenInHrs;
    data['ISMTPLTA_EffortInHrs'] = this.iSMTPLTAEffortInHrs;
    data['ISMDRPT_Date'] = this.iSMDRPTDate;
    data['COUNTCHECKLIST'] = this.cOUNTCHECKLIST;
    data['EMPLOYEENAME'] = this.eMPLOYEENAME;
    data['EMPLOYEECODE'] = this.eMPLOYEECODE;
    data['DEPTNAME'] = this.dEPTNAME;
    data['DESGNAME'] = this.dESGNAME;
    data['HRME_Id'] = this.hRMEId;
    data['ISMDRPT_Remarks'] = this.iSMDRPTRemarks;
    data['ISMTPLTA_Id'] = this.iSMTPLTAId;
    data['ISMTCR_Id_rejected'] = this.iSMTCRIdRejected;
    data['ISMMTCAT_TaskCategoryName'] = this.iSMMTCATTaskCategoryName;
    data['TASK_CREATED_BY'] = this.tASKCREATEDBY;
    data['periodicitydailyflag'] = this.periodicitydailyflag;
    data['ISMTAPL_Periodicity'] = this.iSMTAPLPeriodicity;
    return data;
  }
}
